/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* resultsArray(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));

    for (int i = 0; i <= numsSize - k; i++) {
        int valid = 1;
        for (int j = i + 1; j < i + k; j++) {
            if (nums[j] != nums[j - 1] + 1) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            result[i] = nums[i + k - 1];
        } else {
            result[i] = -1;
        }
    }

    return result;
}