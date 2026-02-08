int maximumTotalCost(int* nums, int numsSize) {
    long long pos = nums[0];
    long long neg = nums[0];

    for (int i = 1; i < numsSize; i++) {
        long long new_pos = (pos + nums[i] > neg - nums[i]) ? pos + nums[i] : neg - nums[i];
        long long new_neg = (pos - nums[i] > neg + nums[i]) ? pos - nums[i] : neg + nums[i];
        pos = new_pos;
        neg = new_neg;
    }

    return (pos > neg) ? pos : neg;
}