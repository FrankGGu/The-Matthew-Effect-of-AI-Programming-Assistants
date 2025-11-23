int minOperations(int* target, int targetSize, int* arr, int arrSize) {
    int *map = (int*)malloc(1000001 * sizeof(int));
    for (int i = 0; i <= 1000000; i++) map[i] = -1;
    for (int i = 0; i < targetSize; i++) map[target[i]] = i;

    int *lis = (int*)malloc(arrSize * sizeof(int));
    int len = 0;

    for (int i = 0; i < arrSize; i++) {
        if (map[arr[i]] == -1) continue;
        int pos = map[arr[i]];
        if (len == 0 || pos > lis[len - 1]) {
            lis[len++] = pos;
        } else {
            int left = 0, right = len - 1;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (lis[mid] < pos) left = mid + 1;
                else right = mid;
            }
            lis[left] = pos;
        }
    }

    free(map);
    free(lis);
    return targetSize - len;
}