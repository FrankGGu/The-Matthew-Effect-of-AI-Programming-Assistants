#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** minimumAbsDifference(int* arr, int arrSize, int* returnSize, int** returnColumnSizes) {
    qsort(arr, arrSize, sizeof(int), compare);

    int min_diff = INT_MAX;
    for (int i = 0; i < arrSize - 1; i++) {
        int current_diff = arr[i+1] - arr[i];
        if (current_diff < min_diff) {
            min_diff = current_diff;
        }
    }

    int** result = (int**)malloc(sizeof(int*) * (arrSize - 1));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (arrSize - 1));
    int count = 0;

    for (int i = 0; i < arrSize - 1; i++) {
        if ((arr[i+1] - arr[i]) == min_diff) {
            result[count] = (int*)malloc(sizeof(int) * 2);
            result[count][0] = arr[i];
            result[count][1] = arr[i+1];
            (*returnColumnSizes)[count] = 2;
            count++;
        }
    }

    *returnSize = count;
    return result;
}