#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSkips(vector<int>& dist, int speed, int hoursBefore) {
        int n = dist.size();
        vector<vector<long long>> dp(n + 1, vector<long long>(n + 1, 1e18));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= n; ++j) {
                dp[i][j] = dp[i - 1][j] + dist[i - 1];
                if (j > 0) {
                    dp[i][j] = min(dp[i][j], (dp[i - 1][j - 1] + dist[i - 1] + speed - 1) / speed * speed);
                }
            }
        }

        for (int j = 0; j <= n; ++j) {
            if (dp[n][j] <= (long long)hoursBefore * speed) {
                return j;
            }
        }

        return -1;
    }
};