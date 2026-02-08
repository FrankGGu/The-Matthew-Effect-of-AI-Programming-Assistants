class Solution {
public:
    int countSpecialSubsequences(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        vector<long long> dp(4, 0);
        dp[0] = 1; // Base case: empty subsequence

        for (int num : nums) {
            if (num == 0) {
                dp[0] = (2 * dp[0]) % MOD; // Include or exclude '0'
            } else if (num == 1) {
                dp[1] = (dp[1] + dp[0]) % MOD; // Count subsequences ending with '1'
            } else if (num == 2) {
                dp[2] = (dp[2] + dp[1]) % MOD; // Count subsequences ending with '2'
            } else if (num == 3) {
                dp[3] = (dp[3] + dp[2]) % MOD; // Count subsequences ending with '3'
            }
        }

        return (dp[3] - 1 + MOD) % MOD; // Exclude the empty subsequence
    }
};