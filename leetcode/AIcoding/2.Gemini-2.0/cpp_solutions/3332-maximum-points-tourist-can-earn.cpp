#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPoints(vector<int>& attractions, int money) {
        int n = attractions.size();
        vector<int> dp(money + 1, 0);

        for (int i = 0; i < n; ++i) {
            vector<int> new_dp = dp;
            for (int j = attractions[i]; j <= money; ++j) {
                new_dp[j] = max(new_dp[j], dp[j - attractions[i]] + 1);
            }
            dp = new_dp;
        }

        return dp[money];
    }
};