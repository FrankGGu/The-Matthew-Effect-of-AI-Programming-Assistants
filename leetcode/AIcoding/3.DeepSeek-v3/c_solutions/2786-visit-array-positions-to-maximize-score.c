long long maxScore(int* nums, int numsSize, int x) {
    long long even = nums[0] - (nums[0] % 2 == 0 ? 0 : x);
    long long odd = nums[0] - (nums[0] % 2 == 0 ? x : 0);

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            even = (even + nums[i] > odd + nums[i] - x) ? even + nums[i] : odd + nums[i] - x;
        } else {
            odd = (odd + nums[i] > even + nums[i] - x) ? odd + nums[i] : even + nums[i] - x;
        }
    }

    return (even > odd) ? even : odd;
}