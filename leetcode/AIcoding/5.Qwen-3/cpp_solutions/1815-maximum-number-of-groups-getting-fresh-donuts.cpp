#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int maxGroups(int n) {
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                if (i - j >= 0) {
                    dp[i] = max(dp[i], dp[i - j] + 1);
                }
            }
        }
        return dp[n];
    }
};