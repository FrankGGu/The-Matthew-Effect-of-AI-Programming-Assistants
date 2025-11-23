class Solution {
public:
    int mincostTickets(vector<int>& days, vector<int>& costs) {
        vector<int> dp(366, 0);
        unordered_set<int> travelDays(days.begin(), days.end());

        for (int day = 1; day <= 365; ++day) {
            if (travelDays.count(day)) {
                dp[day] = min({dp[day - 1] + costs[0], 
                               dp[max(0, day - 7)] + costs[1], 
                               dp[max(0, day - 30)] + costs[2]});
            } else {
                dp[day] = dp[day - 1];
            }
        }

        return dp[365];
    }
};