class Solution {
public:
    int sumOfPower(vector<int>& nums, int k) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        vector<vector<long long>> dp(k + 1, vector<long long>(n + 1, 0));
        dp[0][0] = 1;

        for (int num : nums) {
            for (int sum = k; sum >= 0; --sum) {
                for (int cnt = n; cnt >= 0; --cnt) {
                    if (sum + num <= k && cnt + 1 <= n) {
                        dp[sum + num][cnt + 1] = (dp[sum + num][cnt + 1] + dp[sum][cnt]) % MOD;
                    }
                }
            }
        }

        long long result = 0;
        for (int cnt = 1; cnt <= n; ++cnt) {
            long long power = 1;
            for (int i = 0; i < cnt - 1; ++i) {
                power = (power * 2) % MOD;
            }
            result = (result + dp[k][cnt] * power) % MOD;
        }

        return result;
    }
};