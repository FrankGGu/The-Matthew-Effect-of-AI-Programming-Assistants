void nextPermutation(int* nums, int numsSize) {
    int i = numsSize - 2;
    while (i >= 0 && nums[i] >= nums[i + 1]) {
        i--;
    }
    if (i >= 0) {
        int j = numsSize - 1;
        while (nums[j] <= nums[i]) {
            j--;
        }
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
    for (int left = i + 1, right = numsSize - 1; left < right; left++, right--) {
        int temp = nums[left];
        nums[left] = nums[right];
        nums[right] = temp;
    }
}