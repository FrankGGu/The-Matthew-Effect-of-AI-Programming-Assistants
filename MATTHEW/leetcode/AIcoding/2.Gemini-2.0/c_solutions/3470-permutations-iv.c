#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int permuteUniqueHelper(int* nums, int numsSize, int* count, int* result, int resultSize, int** returnArray, int* returnSize) {
    if (resultSize == numsSize) {
        int* newResult = (int*)malloc(sizeof(int) * numsSize);
        for (int i = 0; i < numsSize; i++) {
            newResult[i] = result[i];
        }
        returnArray[*returnSize] = newResult;
        (*returnSize)++;
        return 0;
    }

    for (int i = 0; i < numsSize; i++) {
        if (count[i] > 0) {
            count[i]--;
            result[resultSize] = nums[i];
            permuteUniqueHelper(nums, numsSize, count, result, resultSize + 1, returnArray, returnSize);
            count[i]++;
        }
    }

    return 0;
}

int** permuteUnique(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    int* count = (int*)calloc(numsSize, sizeof(int));
    int* uniqueNums = (int*)malloc(sizeof(int) * numsSize);
    int uniqueSize = 0;
    int* freq = (int*)calloc(21, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] + 10]++;
    }

    for (int i = 0; i < 21; i++) {
        if (freq[i] > 0) {
            uniqueNums[uniqueSize++] = i - 10;
        }
    }

    int totalPermutations = 1;
    for (int i = 1; i <= numsSize; i++) {
        totalPermutations *= i;
    }
    for (int i = 0; i < 21; i++) {
        if (freq[i] > 0) {
            int fact = 1;
            for (int j = 1; j <= freq[i]; j++) {
                fact *= j;
            }
            totalPermutations /= fact;
        }
    }

    int** returnArray = (int**)malloc(sizeof(int*) * totalPermutations);
    *returnColumnSizes = (int*)malloc(sizeof(int) * totalPermutations);
    *returnSize = 0;

    int* result = (int*)malloc(sizeof(int) * numsSize);

    for (int i = 0; i < numsSize; i++) {
        count[i] = 1;
    }

    int* sortedNums = (int*)malloc(sizeof(int) * numsSize);
    for(int i = 0; i < numsSize; i++){
        sortedNums[i] = nums[i];
    }

    qsort(sortedNums, numsSize, sizeof(int), (int (*)(const void *, const void *))compare);

    permuteUniqueHelper(sortedNums, numsSize, count, result, 0, returnArray, returnSize);

    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = numsSize;
    }

    free(count);
    free(uniqueNums);
    free(freq);
    free(result);
    free(sortedNums);

    return returnArray;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}