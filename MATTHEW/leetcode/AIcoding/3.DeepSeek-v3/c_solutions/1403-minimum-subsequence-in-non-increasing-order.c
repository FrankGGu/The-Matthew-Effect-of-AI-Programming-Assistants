/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* minSubsequence(int* nums, int numsSize, int* returnSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (nums[j] < nums[j + 1]) {
                int temp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = temp;
            }
        }
    }

    int sum = 0;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        count++;
        if (sum > total - sum) {
            break;
        }
    }

    *returnSize = count;
    int* result = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        result[i] = nums[i];
    }

    return result;
}