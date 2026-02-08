/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* resultsArray(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));

    int* dec = (int*)malloc(numsSize * sizeof(int));
    int left = 0, right = -1;

    for (int i = 0; i < *returnSize; i++) {
        while (left <= right && dec[left] < i) {
            left++;
        }

        for (int j = i + k - 1; j > i + k - 2 && j < numsSize; j--) {
            while (left <= right && nums[dec[right]] <= nums[j]) {
                right--;
            }
            dec[++right] = j;
        }

        if (nums[i + k - 1] - nums[i] == k - 1) {
            int valid = 1;
            for (int j = i + 1; j < i + k; j++) {
                if (nums[j] != nums[j - 1] + 1) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                result[i] = nums[i + k - 1];
                continue;
            }
        }

        result[i] = nums[dec[left]];
    }

    free(dec);
    return result;
}