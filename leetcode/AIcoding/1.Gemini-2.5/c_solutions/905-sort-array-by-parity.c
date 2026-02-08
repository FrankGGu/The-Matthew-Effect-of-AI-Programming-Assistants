int* sortArrayByParity(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int left = 0;
    int right = numsSize - 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[left++] = nums[i];
        } else {
            result[right--] = nums[i];
        }
    }
    return result;
}