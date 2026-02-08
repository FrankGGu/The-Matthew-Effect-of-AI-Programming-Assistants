#include <vector>
#include <string>
#include <algorithm>

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

        vector<vector<int>> dp(m + 1, vector<int>(n, 1e9));
        for (int i = 0; i < n; ++i) {
            dp[0][i] = 0;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (dp[i][j] != 1e9) {
                    for (int k : pos[key[i] - 'a']) {
                        int diff = abs(j - k);
                        int cost = min(diff, n - diff);
                        dp[i + 1][k] = min(dp[i + 1][k], dp[i][j] + cost + 1);
                    }
                }
            }
        }

        int ans = 1e9;
        for (int i = 0; i < n; ++i) {
            ans = min(ans, dp[m][i]);
        }

        return ans;
    }
};