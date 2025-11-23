#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int collectTheTrees(vector<int>& tree, int k) {
        int n = tree.size();
        vector<vector<int>> dp(n, vector<int>(k + 1, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j <= k; ++j) {
                if (i == 0) {
                    dp[i][j] = (tree[i] == 1 ? 0 : 1);
                } else {
                    dp[i][j] = dp[i - 1][j];
                    if (j > 0) {
                        dp[i][j] = min(dp[i][j], dp[i - 1][j - 1]);
                    }
                    if (tree[i] == 1) {
                        dp[i][j] += 0;
                    } else {
                        dp[i][j] += 1;
                    }
                }
            }
        }

        return dp[n - 1][k];
    }
};