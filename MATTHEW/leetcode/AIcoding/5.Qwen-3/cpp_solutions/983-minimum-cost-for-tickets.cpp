#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int mincostTickets(vector<int>& days, vector<int>& costs) {
        int n = days.size();
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            int day = days[i - 1];
            dp[i] = dp[i - 1] + costs[0];

            int j = i - 1;
            while (j >= 0 && days[j] + 7 > day) {
                dp[i] = min(dp[i], dp[j] + costs[1]);
                --j;
            }

            j = i - 1;
            while (j >= 0 && days[j] + 30 > day) {
                dp[i] = min(dp[i], dp[j] + costs[2]);
                --j;
            }
        }

        return dp[n];
    }
};