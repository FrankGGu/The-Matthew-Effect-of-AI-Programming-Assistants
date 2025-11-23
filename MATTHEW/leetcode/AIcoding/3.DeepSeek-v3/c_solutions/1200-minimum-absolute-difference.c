/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** minimumAbsDifference(int* arr, int arrSize, int* returnSize, int** returnColumnSizes) {
    qsort(arr, arrSize, sizeof(int), cmpfunc);

    int min_diff = INT_MAX;
    for (int i = 0; i < arrSize - 1; i++) {
        int diff = arr[i+1] - arr[i];
        if (diff < min_diff) {
            min_diff = diff;
        }
    }

    int count = 0;
    for (int i = 0; i < arrSize - 1; i++) {
        if (arr[i+1] - arr[i] == min_diff) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int index = 0;
    for (int i = 0; i < arrSize - 1; i++) {
        if (arr[i+1] - arr[i] == min_diff) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = arr[i];
            result[index][1] = arr[i+1];
            (*returnColumnSizes)[index] = 2;
            index++;
        }
    }

    return result;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}