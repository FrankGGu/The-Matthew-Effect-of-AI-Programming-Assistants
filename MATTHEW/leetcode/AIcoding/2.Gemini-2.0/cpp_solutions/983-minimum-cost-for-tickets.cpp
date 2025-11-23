#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mincostTickets(vector<int>& days, vector<int>& costs) {
        int n = days.size();
        vector<int> dp(days.back() + 1, 0);

        for (int i = 1; i < dp.size(); ++i) {
            if (find(days.begin(), days.end(), i) == days.end()) {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = dp[i - 1] + costs[0];
                dp[i] = min(dp[i], (i >= 7 ? dp[i - 7] : 0) + costs[1]);
                dp[i] = min(dp[i], (i >= 30 ? dp[i - 30] : 0) + costs[2]);
            }
        }

        return dp.back();
    }
};