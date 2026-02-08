#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& houses, vector<int>& cost, int k, int m) {
        int n = houses.size();
        vector<vector<int>> dp(k + 1, vector<int>(n, INT_MAX));
        vector<vector<int>> dist(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                if (i == j) {
                    dist[i][j] = 0;
                } else {
                    dist[i][j] = dist[i][j - 1] + abs(houses[j] - houses[j - 1]);
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            dp[1][i] = dist[0][i];
        }

        for (int b = 2; b <= k; ++b) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < i; ++j) {
                    if (dp[b - 1][j] != INT_MAX) {
                        dp[b][i] = min(dp[b][i], dp[b - 1][j] + dist[j + 1][i]);
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            result = min(result, dp[k][i]);
        }

        return result;
    }
};