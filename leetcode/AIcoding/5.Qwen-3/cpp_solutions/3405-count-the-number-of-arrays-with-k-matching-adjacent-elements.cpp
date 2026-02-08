#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int colorTheArray(int n, int k) {
        vector<int> dp(n, 0);
        dp[0] = 1;
        for (int i = 1; i < n; ++i) {
            dp[i] = dp[i - 1] * (k - 1);
        }
        return dp[n - 1];
    }
};