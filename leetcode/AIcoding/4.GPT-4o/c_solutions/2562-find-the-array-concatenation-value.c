int findTheArrayConcVal(int* nums, int numsSize) {
    int left = 0, right = numsSize - 1, total = 0;
    while (left <= right) {
        if (left == right) {
            total += nums[left];
        } else {
            total += (int)(pow(10, (int)(log10(nums[right]) + 1)) * nums[left] + nums[right]);
        }
        left++;
        right--;
    }
    return total;
}