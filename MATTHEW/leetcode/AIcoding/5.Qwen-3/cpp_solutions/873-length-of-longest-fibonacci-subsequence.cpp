#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestLongestFibonacciSubsequence(vector<int>& arr) {
        int n = arr.size();
        vector<unordered_map<int, int>> dp(n);
        int maxLen = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                int prev = arr[i] - arr[j];
                if (dp[j].find(prev) != dp[j].end()) {
                    dp[i][arr[j]] = dp[j][prev] + 1;
                    maxLen = max(maxLen, dp[i][arr[j]]);
                } else {
                    dp[i][arr[j]] = 2;
                }
            }
        }

        return maxLen;
    }
};