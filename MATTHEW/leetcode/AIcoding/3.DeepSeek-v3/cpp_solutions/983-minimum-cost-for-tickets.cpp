class Solution {
public:
    int mincostTickets(vector<int>& days, vector<int>& costs) {
        unordered_set<int> travelDays(days.begin(), days.end());
        vector<int> dp(366, 0);

        for (int i = 1; i <= 365; ++i) {
            if (travelDays.find(i) == travelDays.end()) {
                dp[i] = dp[i-1];
            } else {
                int minCost = dp[i-1] + costs[0];
                minCost = min(minCost, dp[max(0, i-7)] + costs[1]);
                minCost = min(minCost, dp[max(0, i-30)] + costs[2]);
                dp[i] = minCost;
            }
        }

        return dp[365];
    }
};