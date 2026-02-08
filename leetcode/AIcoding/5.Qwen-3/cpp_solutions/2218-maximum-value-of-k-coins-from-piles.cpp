#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValueOfKCoins(vector<vector<int>>& piles, int k) {
        vector<int> dp(k + 1, 0);
        for (const auto& pile : piles) {
            vector<int> new_dp(dp);
            for (int i = 1; i <= k; ++i) {
                int sum = 0;
                for (int j = 0; j < min(i, (int)pile.size()); ++j) {
                    sum += pile[j];
                    new_dp[i] = max(new_dp[i], dp[i - j - 1] + sum);
                }
            }
            dp = new_dp;
        }
        return dp[k];
    }
};