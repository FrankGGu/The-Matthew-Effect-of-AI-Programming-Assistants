int* separateSquares(int* nums, int numsSize, int* returnSize) {
    int *result = (int*)malloc(numsSize * sizeof(int));
    int left = 0, right = numsSize - 1;
    *returnSize = numsSize;

    while (left <= right) {
        if (nums[right] >= 0) {
            result[right] = nums[right];
            right--;
        } else {
            result[left] = nums[left];
            left++;
        }
    }

    return result;
}