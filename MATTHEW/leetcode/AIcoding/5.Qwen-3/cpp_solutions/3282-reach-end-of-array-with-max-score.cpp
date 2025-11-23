#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maxScore(vector<int>& arr) {
        int n = arr.size();
        vector<int> dp(n, INT_MIN);
        dp[0] = arr[0];

        for (int i = 1; i < n; ++i) {
            for (int j = 1; j <= arr[i-1] && i - j >= 0; ++j) {
                if (dp[i - j] != INT_MIN) {
                    dp[i] = max(dp[i], dp[i - j] + arr[i]);
                }
            }
        }

        return dp[n - 1];
    }
};