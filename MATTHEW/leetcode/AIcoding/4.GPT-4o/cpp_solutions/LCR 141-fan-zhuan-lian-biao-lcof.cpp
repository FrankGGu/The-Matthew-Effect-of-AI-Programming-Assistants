class Solution {
public:
    int trainingPlan(int n, vector<int>& days, vector<int>& calories) {
        vector<int> dp(n + 1, 0);
        for (int i = 0; i < days.size(); ++i) {
            for (int j = n; j >= days[i]; --j) {
                dp[j] = max(dp[j], dp[j - days[i]] + calories[i]);
            }
        }
        return dp[n];
    }
};