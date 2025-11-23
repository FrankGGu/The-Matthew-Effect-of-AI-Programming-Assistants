int* rearrangeArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * numsSize);
    int left = 0, right = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[left] = nums[i];
            left += 2;
        } else {
            result[right + 1] = nums[i];
            right += 2;
        }
    }

    *returnSize = numsSize;
    return result;
}