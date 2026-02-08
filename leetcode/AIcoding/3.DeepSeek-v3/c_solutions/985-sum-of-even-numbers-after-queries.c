/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sumEvenAfterQueries(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int evenSum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            evenSum += nums[i];
        }
    }

    for (int i = 0; i < queriesSize; i++) {
        int val = queries[i][0];
        int index = queries[i][1];

        if (nums[index] % 2 == 0) {
            evenSum -= nums[index];
        }

        nums[index] += val;

        if (nums[index] % 2 == 0) {
            evenSum += nums[index];
        }

        result[i] = evenSum;
    }

    return result;
}