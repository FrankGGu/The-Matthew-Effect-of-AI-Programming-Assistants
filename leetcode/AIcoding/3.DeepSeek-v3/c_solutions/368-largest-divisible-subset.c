/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* largestDivisibleSubset(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    // Sort the array
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (nums[j] > nums[j + 1]) {
                int temp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = temp;
            }
        }
    }

    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* prev = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        prev[i] = -1;
    }

    int maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] % nums[j] == 0 && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
                prev[i] = j;
            }
        }
        if (dp[i] > dp[maxIndex]) {
            maxIndex = i;
        }
    }

    *returnSize = dp[maxIndex];
    int* result = (int*)malloc((*returnSize) * sizeof(int));

    int index = maxIndex;
    for (int i = *returnSize - 1; i >= 0; i--) {
        result[i] = nums[index];
        index = prev[index];
    }

    free(dp);
    free(prev);

    return result;
}