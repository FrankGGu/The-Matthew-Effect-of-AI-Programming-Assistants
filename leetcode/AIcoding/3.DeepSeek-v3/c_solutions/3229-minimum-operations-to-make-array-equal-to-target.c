int minimumOperations(int* nums, int numsSize, int* target, int targetSize) {
    long long diff = 0;
    long long res = 0;

    for (int i = 0; i < numsSize; i++) {
        long long curr_diff = (long long)target[i] - nums[i];
        if (diff > 0 && curr_diff < diff) {
            res += diff - curr_diff;
        } else if (diff < 0 && curr_diff > diff) {
            res += curr_diff - diff;
        }
        diff = curr_diff;
    }

    res += llabs(diff);
    return res;
}