#include <stdlib.h>

int* findKDistantIndices(int* nums, int numsSize, int key, int k, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == key) {
            for (int j = i - k; j <= i + k; j++) {
                if (j >= 0 && j < numsSize) {
                    result[index++] = j;
                }
            }
        }
    }

    // Remove duplicates and sort
    qsort(result, index, sizeof(int), (int(*)(const void*, const void*))strcmp);
    int* uniqueResult = (int*)malloc(index * sizeof(int));
    int uniqueIndex = 0;

    for (int i = 0; i < index; i++) {
        if (i == 0 || result[i] != result[i - 1]) {
            uniqueResult[uniqueIndex++] = result[i];
        }
    }

    free(result);
    *returnSize = uniqueIndex;
    return uniqueResult;
}