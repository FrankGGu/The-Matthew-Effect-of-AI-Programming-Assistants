int maxSum(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    if (numsSize == 1) return nums[0];

    int prev2 = 0, prev1 = nums[0], current;

    for (int i = 1; i < numsSize; i++) {
        current = fmax(prev1, prev2 + nums[i]);
        prev2 = prev1;
        prev1 = current;
    }

    return prev1;
}