int sumOfGoodSubsequences(int* nums, int numsSize) {
    const int MOD = 1000000007;
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) max_val = nums[i];
    }

    long long* dp = (long long*)calloc(max_val + 1, sizeof(long long));
    long long* count = (long long*)calloc(max_val + 1, sizeof(long long));

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        long long sum_here = num;
        long long count_here = 1;

        if (num - 1 >= 0) {
            sum_here = (sum_here + dp[num - 1] + count[num - 1] * num) % MOD;
            count_here = (count_here + count[num - 1]) % MOD;
        }
        if (num + 1 <= max_val) {
            sum_here = (sum_here + dp[num + 1] + count[num + 1] * num) % MOD;
            count_here = (count_here + count[num + 1]) % MOD;
        }

        dp[num] = (dp[num] + sum_here) % MOD;
        count[num] = (count[num] + count_here) % MOD;
    }

    long long result = 0;
    for (int i = 0; i <= max_val; i++) {
        result = (result + dp[i]) % MOD;
    }

    free(dp);
    free(count);
    return result;
}