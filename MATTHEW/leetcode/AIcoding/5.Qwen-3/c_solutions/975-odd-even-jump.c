#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* oddEvenJumps(int* arr, int arrSize, int* returnSize) {
    int* sorted = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        sorted[i] = arr[i];
    }
    qsort(sorted, arrSize, sizeof(int), compare);

    int* indexMap = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        indexMap[i] = -1;
    }

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            if (arr[i] == sorted[j]) {
                indexMap[i] = j;
                break;
            }
        }
    }

    int* odd = (int*)malloc(arrSize * sizeof(int));
    int* even = (int*)malloc(arrSize * sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        odd[i] = 0;
        even[i] = 0;
    }

    odd[arrSize - 1] = 1;
    even[arrSize - 1] = 1;

    for (int i = arrSize - 2; i >= 0; i--) {
        int idx = indexMap[i];
        int next = -1;
        for (int j = idx + 1; j < arrSize; j++) {
            if (sorted[j] >= arr[i]) {
                next = j;
                break;
            }
        }
        if (next != -1) {
            odd[i] = even[next];
        }

        next = -1;
        for (int j = idx - 1; j >= 0; j--) {
            if (sorted[j] <= arr[i]) {
                next = j;
                break;
            }
        }
        if (next != -1) {
            even[i] = odd[next];
        }
    }

    int* result = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        result[i] = odd[i];
    }

    *returnSize = arrSize;
    free(sorted);
    free(indexMap);
    free(odd);
    free(even);
    return result;
}