#include <vector>

using namespace std;

class Solution {
public:
    int ways(vector<string>& pizza, int k) {
        int m = pizza.size();
        int n = pizza[0].size();
        vector<vector<int>> apples(m + 1, vector<int>(n + 1, 0));
        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                apples[i][j] = apples[i + 1][j] + apples[i][j + 1] - apples[i + 1][j + 1] + (pizza[i][j] == 'A');
            }
        }

        vector<vector<vector<int>>> dp(k, vector<vector<int>>(m, vector<int>(n, 0)));
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp[0][i][j] = (apples[i][j] > 0);
            }
        }

        int mod = 1e9 + 7;
        for (int cut = 1; cut < k; cut++) {
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    for (int row = i + 1; row < m; row++) {
                        if (apples[i][j] - apples[row][j] > 0) {
                            dp[cut][i][j] = (dp[cut][i][j] + dp[cut - 1][row][j]) % mod;
                        }
                    }
                    for (int col = j + 1; col < n; col++) {
                        if (apples[i][j] - apples[i][col] > 0) {
                            dp[cut][i][j] = (dp[cut][i][j] + dp[cut - 1][i][col]) % mod;
                        }
                    }
                }
            }
        }

        return dp[k - 1][0][0];
    }
};