#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfWays(int n, int m, vector<vector<int>>& sources, vector<vector<int>>& targets) {
        vector<vector<int>> dp(n, vector<int>(m, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (sources[i][0] == targets[j][0] && sources[i][1] == targets[j][1]) {
                    dp[i][j] = 1;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (dp[i][j] == 0) continue;

                for (int k = 0; k < n; ++k) {
                    for (int l = 0; l < m; ++l) {
                        if (sources[k][0] == targets[l][0] && sources[k][1] == targets[l][1]) {
                            if (sources[k][0] > targets[j][0] || (sources[k][0] == targets[j][0] && sources[k][1] > targets[j][1])) {
                                dp[k][l] += dp[i][j];
                            }
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                result += dp[i][j];
            }
        }

        return result;
    }
};