#include <stdlib.h>

int* sumEvenAfterQueries(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int currentEvenSum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            currentEvenSum += nums[i];
        }
    }

    *returnSize = queriesSize;
    int* result = (int*)malloc(sizeof(int) * queriesSize);

    for (int i = 0; i < queriesSize; i++) {
        int val = queries[i][0];
        int index = queries[i][1];

        if (nums[index] % 2 == 0) {
            currentEvenSum -= nums[index];
        }

        nums[index] += val;

        if (nums[index] % 2 == 0) {
            currentEvenSum += nums[index];
        }
        result[i] = currentEvenSum;
    }

    return result;
}