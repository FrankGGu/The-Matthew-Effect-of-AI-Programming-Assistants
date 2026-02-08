typedef struct {
    int sum;
    int index;
} Pair;

int minSumOfLengths(int* arr, int arrSize, int target) {
    int* left = (int*)malloc(arrSize * sizeof(int));
    int* right = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        left[i] = INT_MAX;
        right[i] = INT_MAX;
    }

    int sum = 0;
    int leftMin = INT_MAX;
    Pair* map = (Pair*)malloc((arrSize + 1) * sizeof(Pair));
    int mapSize = 0;
    map[mapSize].sum = 0;
    map[mapSize].index = -1;
    mapSize++;

    for (int i = 0; i < arrSize; i++) {
        sum += arr[i];
        int need = sum - target;
        for (int j = 0; j < mapSize; j++) {
            if (map[j].sum == need) {
                int len = i - map[j].index;
                if (leftMin != INT_MAX) {
                    left[i] = len;
                }
                if (map[j].index == -1) {
                    leftMin = (leftMin < len) ? leftMin : len;
                } else {
                    leftMin = (leftMin < len) ? leftMin : len;
                }
            }
        }
        left[i] = leftMin;
        map[mapSize].sum = sum;
        map[mapSize].index = i;
        mapSize++;
    }

    sum = 0;
    int rightMin = INT_MAX;
    mapSize = 0;
    map[mapSize].sum = 0;
    map[mapSize].index = arrSize;
    mapSize++;

    for (int i = arrSize - 1; i >= 0; i--) {
        sum += arr[i];
        int need = sum - target;
        for (int j = 0; j < mapSize; j++) {
            if (map[j].sum == need) {
                int len = map[j].index - i;
                if (rightMin != INT_MAX) {
                    right[i] = len;
                }
                if (map[j].index == arrSize) {
                    rightMin = (rightMin < len) ? rightMin : len;
                } else {
                    rightMin = (rightMin < len) ? rightMin : len;
                }
            }
        }
        right[i] = rightMin;
        map[mapSize].sum = sum;
        map[mapSize].index = i;
        mapSize++;
    }

    int result = INT_MAX;
    for (int i = 0; i < arrSize - 1; i++) {
        if (left[i] != INT_MAX && right[i + 1] != INT_MAX) {
            int total = left[i] + right[i + 1];
            if (total < result) {
                result = total;
            }
        }
    }

    free(left);
    free(right);
    free(map);

    return result == INT_MAX ? -1 : result;
}