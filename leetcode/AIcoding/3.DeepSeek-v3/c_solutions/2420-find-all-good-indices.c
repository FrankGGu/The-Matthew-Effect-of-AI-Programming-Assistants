/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* goodIndices(int* nums, int numsSize, int k, int* returnSize) {
    int* nonInc = (int*)malloc(numsSize * sizeof(int));
    int* nonDec = (int*)malloc(numsSize * sizeof(int));
    int* result = (int*)malloc(numsSize * sizeof(int));

    nonInc[0] = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i - 1]) {
            nonInc[i] = nonInc[i - 1] + 1;
        } else {
            nonInc[i] = 1;
        }
    }

    nonDec[numsSize - 1] = 1;
    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] <= nums[i + 1]) {
            nonDec[i] = nonDec[i + 1] + 1;
        } else {
            nonDec[i] = 1;
        }
    }

    *returnSize = 0;
    for (int i = k; i < numsSize - k; i++) {
        if (nonInc[i - 1] >= k && nonDec[i + 1] >= k) {
            result[(*returnSize)++] = i;
        }
    }

    free(nonInc);
    free(nonDec);
    return result;
}