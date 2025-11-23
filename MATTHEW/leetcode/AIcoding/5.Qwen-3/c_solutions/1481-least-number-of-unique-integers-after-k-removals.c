#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int* findLeastNumOfUniqueInts(int* arr, int arrSize, int k, int* returnSize) {
    int *count = (int *)calloc(arrSize, sizeof(int));
    int *freq = (int *)malloc(arrSize * sizeof(int));
    int uniqueCount = 0;

    for (int i = 0; i < arrSize; i++) {
        int found = 0;
        for (int j = 0; j < uniqueCount; j++) {
            if (arr[i] == freq[j]) {
                count[j]++;
                found = 1;
                break;
            }
        }
        if (!found) {
            freq[uniqueCount] = arr[i];
            count[uniqueCount] = 1;
            uniqueCount++;
        }
    }

    qsort(count, uniqueCount, sizeof(int), compare);

    int i = 0;
    while (k > 0 && i < uniqueCount) {
        if (count[i] <= k) {
            k -= count[i];
            i++;
        } else {
            break;
        }
    }

    *returnSize = uniqueCount - i;
    int *result = (int *)malloc(sizeof(int));
    result[0] = *returnSize;
    free(count);
    free(freq);
    return result;
}