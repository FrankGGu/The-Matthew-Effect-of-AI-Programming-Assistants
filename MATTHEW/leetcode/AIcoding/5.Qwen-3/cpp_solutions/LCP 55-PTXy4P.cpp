#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTime(int n, vector<int>& time) {
        vector<int> dp(n, 0);
        for (int i = 0; i < n; ++i) {
            if (i == 0) {
                dp[i] = time[i];
            } else {
                dp[i] = min(dp[i - 1] + time[i], dp[i - 1] + time[i] / 2);
            }
        }
        return dp[n - 1];
    }
};