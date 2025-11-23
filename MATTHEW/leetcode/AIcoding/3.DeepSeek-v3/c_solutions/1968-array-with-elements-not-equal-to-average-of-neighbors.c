/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* rearrangeArray(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize - 1; i++) {
        if ((nums[i] < nums[i + 1] && i > 0 && nums[i - 1] + nums[i + 1] == 2 * nums[i]) ||
            (nums[i] > nums[i + 1] && i > 0 && nums[i - 1] + nums[i + 1] == 2 * nums[i])) {
            int temp = nums[i];
            nums[i] = nums[i + 1];
            nums[i + 1] = temp;
        }
    }

    for (int i = numsSize - 1; i > 0; i--) {
        if ((nums[i] < nums[i - 1] && i < numsSize - 1 && nums[i - 1] + nums[i + 1] == 2 * nums[i]) ||
            (nums[i] > nums[i - 1] && i < numsSize - 1 && nums[i - 1] + nums[i + 1] == 2 * nums[i])) {
            int temp = nums[i];
            nums[i] = nums[i - 1];
            nums[i - 1] = temp;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }

    return result;
}