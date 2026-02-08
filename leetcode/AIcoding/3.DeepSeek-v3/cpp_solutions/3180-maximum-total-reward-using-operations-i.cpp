class Solution {
public:
    int maxTotalReward(vector<int>& rewardValues) {
        sort(rewardValues.begin(), rewardValues.end());
        rewardValues.erase(unique(rewardValues.begin(), rewardValues.end()), rewardValues.end());
        int maxSum = 2 * rewardValues.back();
        vector<bool> dp(maxSum + 1, false);
        dp[0] = true;
        for (int num : rewardValues) {
            for (int i = num; i < maxSum + 1; ++i) {
                if (dp[i - num] && i - num < num) {
                    dp[i] = true;
                }
            }
        }
        for (int i = maxSum; i >= 0; --i) {
            if (dp[i]) {
                return i;
            }
        }
        return 0;
    }
};