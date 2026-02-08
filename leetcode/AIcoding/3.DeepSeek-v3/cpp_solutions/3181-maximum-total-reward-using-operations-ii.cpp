class Solution {
public:
    int maxTotalReward(vector<int>& rewardValues) {
        sort(rewardValues.begin(), rewardValues.end());
        rewardValues.erase(unique(rewardValues.begin(), rewardValues.end()), rewardValues.end());
        int maxSum = 2 * rewardValues.back();
        vector<bool> dp(maxSum + 1, false);
        dp[0] = true;
        for (int num : rewardValues) {
            for (int j = maxSum; j >= num; --j) {
                if (dp[j - num] && j - num < num) {
                    dp[j] = dp[j] || dp[j - num];
                }
            }
        }
        for (int j = maxSum; j >= 0; --j) {
            if (dp[j]) {
                return j;
            }
        }
        return 0;
    }
};