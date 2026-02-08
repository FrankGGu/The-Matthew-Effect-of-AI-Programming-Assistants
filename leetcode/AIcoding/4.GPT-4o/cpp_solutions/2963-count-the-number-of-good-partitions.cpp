class Solution {
public:
    int countPartitions(vector<int>& nums, int k) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        long long totalSum = accumulate(nums.begin(), nums.end(), 0LL);
        if (totalSum < k) return 0;

        vector<long long> dp(totalSum + 1, 0);
        dp[0] = 1;

        for (int num : nums) {
            for (int j = totalSum; j >= num; --j) {
                dp[j] = (dp[j] + dp[j - num]) % MOD;
            }
        }

        long long result = 0;
        for (int i = k; i <= totalSum; ++i) {
            result = (result + dp[i]) % MOD;
        }

        return (result * modInverse(2, MOD)) % MOD;
    }

private:
    long long modInverse(long long a, long long mod) {
        long long m0 = mod, y = 0, x = 1;
        if (mod == 1) return 0;
        while (a > 1) {
            long long q = a / mod;
            long long t = mod;
            mod = a % mod, a = t;
            t = y;
            y = x - q * y;
            x = t;
        }
        if (x < 0) x += m0;
        return x;
    }
};