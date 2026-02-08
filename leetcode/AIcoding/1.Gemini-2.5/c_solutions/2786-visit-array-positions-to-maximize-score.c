#include <limits.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maximizeScore(int* nums, int numsSize, int x) {
    long long dp_even = LLONG_MIN;
    long long dp_odd = LLONG_MIN;

    if (nums[0] % 2 == 0) {
        dp_even = nums[0];
    } else {
        dp_odd = nums[0];
    }

    for (int i = 1; i < numsSize; i++) {
        long long current_num = nums[i];
        if (current_num % 2 == 0) {
            long long score_from_even = dp_even + current_num;
            long long score_from_odd = dp_odd + current_num - x;
            dp_even = max(score_from_even, score_from_odd);
        } else {
            long long score_from_odd = dp_odd + current_num;
            long long score_from_even = dp_even + current_num - x;
            dp_odd = max(score_from_odd, score_from_even);
        }
    }

    return max(dp_even, dp_odd);
}