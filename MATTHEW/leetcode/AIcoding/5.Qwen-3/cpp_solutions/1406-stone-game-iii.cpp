#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string stoneGameIII(vector<int>& aliceSizes, vector<int>& bobSizes) {
        int n = aliceSizes.size();
        vector<int> dp(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            dp[i] = -dp[i + 1];
            if (i + 1 < n) {
                dp[i] = max(dp[i], -dp[i + 2]);
            }
            if (i + 2 < n) {
                dp[i] = max(dp[i], -dp[i + 3]);
            }
        }
        if (dp[0] > 0) return "Alice";
        else if (dp[0] < 0) return "Bob";
        else return "Tie";
    }
};