#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeTheProfit(int n, vector<vector<int>>& offers) {
        sort(offers.begin(), offers.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        vector<int> dp(offers.size() + 1, 0);
        vector<int> endTimes;
        endTimes.push_back(-1);

        for (const auto& offer : offers) {
            endTimes.push_back(offer[1]);
        }

        for (int i = 1; i <= offers.size(); ++i) {
            int start = offers[i-1][0];
            int gold = offers[i-1][2];

            int prev = upper_bound(endTimes.begin(), endTimes.end(), start - 1) - endTimes.begin() - 1;
            dp[i] = max(dp[i-1], dp[prev] + gold);
        }

        return dp.back();
    }
};