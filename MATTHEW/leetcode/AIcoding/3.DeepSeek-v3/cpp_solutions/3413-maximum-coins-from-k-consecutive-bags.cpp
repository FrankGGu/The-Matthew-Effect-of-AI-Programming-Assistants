#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int maxCoins(vector<int>& bags, int k) {
        sort(bags.begin(), bags.end());
        int n = bags.size();
        vector<int> dp(n, 0);
        int res = 0;

        for (int i = 0; i < n; ++i) {
            int max_val = 0;
            for (int j = 0; j < i; ++j) {
                if (bags[i] - bags[j] <= k) {
                    max_val = max(max_val, dp[j]);
                }
            }
            dp[i] = max_val + bags[i];
            res = max(res, dp[i]);
        }

        return res;
    }
};