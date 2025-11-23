#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostToMakePathEqual(vector<int>& path) {
        int n = path.size();
        vector<int> dp(n, 0);
        for (int i = 1; i < n; ++i) {
            dp[i] = dp[i - 1] + abs(path[i] - path[i - 1]);
        }
        return dp[n - 1];
    }
};