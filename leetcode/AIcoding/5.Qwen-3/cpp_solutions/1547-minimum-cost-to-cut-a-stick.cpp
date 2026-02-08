#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(int n, vector<int>& cuts) {
        vector<int> sortedCuts = cuts;
        sort(sortedCuts.begin(), sortedCuts.end());
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < sortedCuts.size(); ++j) {
                if (sortedCuts[j] == i) {
                    dp[i] = dp[i - 1];
                    break;
                }
                if (sortedCuts[j] > i) {
                    dp[i] = dp[i - 1];
                    break;
                }
                dp[i] = max(dp[i], dp[sortedCuts[j]] + dp[i - sortedCuts[j]]);
            }
        }

        return dp[n];
    }
};