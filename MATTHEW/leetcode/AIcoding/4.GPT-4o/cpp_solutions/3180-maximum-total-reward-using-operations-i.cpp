class Solution {
public:
    long long maximumTotalReward(vector<int>& rewards, vector<vector<int>>& operations) {
        long long totalReward = 0;
        int n = rewards.size();
        vector<long long> dp(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            dp[i + 1] = dp[i] + rewards[i];
        }

        for (const auto& op : operations) {
            int l = op[0], r = op[1];
            long long currentReward = dp[r + 1] - dp[l];
            totalReward = max(totalReward, currentReward);
        }

        return totalReward;
    }
};