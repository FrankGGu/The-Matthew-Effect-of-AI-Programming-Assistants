int* sortArrayByParity(int* nums, int numsSize, int* returnSize) {
    int left = 0;
    int right = numsSize - 1;

    while (left < right) {
        if (nums[left] % 2 == 0) { // nums[left] is even, correct position
            left++;
        } else if (nums[right] % 2 != 0) { // nums[right] is odd, correct position
            right--;
        } else { // nums[left] is odd and nums[right] is even, swap them
            int temp = nums[left];
            nums[left] = nums[right];
            nums[right] = temp;
            left++;
            right--;
        }
    }

    *returnSize = numsSize;
    return nums;
}