#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minCostToPaintWalls(int n, vector<int>& cost, vector<int>& time) {
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = n; j >= 0; --j) {
                if (dp[j] != INT_MAX) {
                    dp[min(j + time[i], n)] = min(dp[min(j + time[i], n)], dp[j] + cost[i]);
                }
            }
        }

        return dp[n];
    }
};