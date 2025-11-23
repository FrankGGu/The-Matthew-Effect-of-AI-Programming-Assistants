#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numMusicPlaylists(int n, int k, int target) {
        vector<vector<long long>> dp(target + 1, vector<long long>(target + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= target; ++i) {
            for (int j = 0; j <= min(i, target); ++j) {
                if (j > 0) {
                    dp[i][j] += dp[i - 1][j - 1] * (n - (j - 1));
                }
                if (i > k) {
                    dp[i][j] += dp[i - 1][j] * max(0, j - k);
                }
                dp[i][j] %= 1000000007;
            }
        }

        return dp[target][k];
    }
};