char** findRestaurant(char** list1, int list1Size, char** list2, int list2Size, int* returnSize) {
    int minSum = INT_MAX;
    int count = 0;

    for (int i = 0; i < list1Size; i++) {
        for (int j = 0; j < list2Size; j++) {
            if (strcmp(list1[i], list2[j]) == 0) {
                int sum = i + j;
                if (sum < minSum) {
                    minSum = sum;
                    count = 1;
                } else if (sum == minSum) {
                    count++;
                }
            }
        }
    }

    char** result = (char**)malloc(count * sizeof(char*));
    int index = 0;

    for (int i = 0; i < list1Size; i++) {
        for (int j = 0; j < list2Size; j++) {
            if (strcmp(list1[i], list2[j]) == 0 && i + j == minSum) {
                result[index++] = list1[i];
            }
        }
    }

    *returnSize = count;
    return result;
}