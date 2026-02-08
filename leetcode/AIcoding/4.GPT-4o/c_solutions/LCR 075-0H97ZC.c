int* relativeSortArray(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int count[1001] = {0};
    int* result = (int*)malloc(sizeof(int) * arr1Size);
    int index = 0;

    for (int i = 0; i < arr1Size; i++) {
        count[arr1[i]]++;
    }

    for (int i = 0; i < arr2Size; i++) {
        while (count[arr2[i]] > 0) {
            result[index++] = arr2[i];
            count[arr2[i]]--;
        }
    }

    for (int i = 0; i < 1001; i++) {
        while (count[i] > 0) {
            result[index++] = i;
            count[i]--;
        }
    }

    *returnSize = arr1Size;
    return result;
}