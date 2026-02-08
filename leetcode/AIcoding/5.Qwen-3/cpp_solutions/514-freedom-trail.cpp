#include <iostream>
#include <vector>
#include <string>
#include <cmath>
#include <queue>

using namespace std;

class Solution {
public:
    int findRotateSteps(string ring, string key) {
        int n = ring.size();
        int m = key.size();
        vector<vector<int>> pos(26);
        for (int i = 0; i < n; ++i) {
            pos[ring[i] - 'a'].push_back(i);
        }

        vector<vector<int>> dp(m, vector<int>(n, INT_MAX));
        for (int i : pos[key[0] - 'a']) {
            dp[0][i] = min(dp[0][i], min(abs(i), n - abs(i)));
        }

        for (int i = 1; i < m; ++i) {
            for (int j : pos[key[i] - 'a']) {
                for (int k : pos[key[i - 1] - 'a']) {
                    int steps = min(abs(j - k), n - abs(j - k)) + dp[i - 1][k];
                    dp[i][j] = min(dp[i][j], steps);
                }
            }
        }

        int result = INT_MAX;
        for (int i : pos[key[m - 1] - 'a']) {
            result = min(result, dp[m - 1][i]);
        }
        return result;
    }
};