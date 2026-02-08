#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minFlipsMonotonic(string s) {
        int n = s.size();
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            if (s[i - 1] == '0') {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = min(dp[i - 1], dp[i - 1] + 1);
            }
        }
        return dp[n];
    }
};