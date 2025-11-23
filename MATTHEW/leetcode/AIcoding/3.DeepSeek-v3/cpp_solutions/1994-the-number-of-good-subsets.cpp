class Solution {
public:
    int numberOfGoodSubsets(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
        vector<int> dp(1 << 10, 0);
        dp[0] = 1;

        vector<int> cnt(31, 0);
        for (int num : nums) {
            cnt[num]++;
        }

        for (int num = 2; num <= 30; ++num) {
            if (cnt[num] == 0) continue;
            int mask = 0;
            bool valid = true;
            for (int i = 0; i < 10; ++i) {
                if (num % primes[i] == 0) {
                    if ((num / primes[i]) % primes[i] == 0) {
                        valid = false;
                        break;
                    }
                    mask |= (1 << i);
                }
            }
            if (!valid) continue;
            for (int prev_mask = (1 << 10) - 1; prev_mask >= 0; --prev_mask) {
                if ((prev_mask & mask) == 0) {
                    dp[prev_mask | mask] = (dp[prev_mask | mask] + (long long)dp[prev_mask] * cnt[num]) % MOD;
                }
            }
        }

        long long res = 0;
        for (int mask = 1; mask < (1 << 10); ++mask) {
            res = (res + dp[mask]) % MOD;
        }

        long long ones = 1;
        for (int i = 0; i < cnt[1]; ++i) {
            ones = (ones * 2) % MOD;
        }

        return (res * ones) % MOD;
    }
};