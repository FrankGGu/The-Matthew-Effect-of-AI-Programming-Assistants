#include <vector>

using namespace std;

class Solution {
public:
    int countRoutes(int start, int finish, int fuel, vector<int>& locations) {
        int n = locations.size();
        int MOD = 1e9 + 7;
        vector<vector<int>> dp(n, vector<int>(fuel + 1, 0));
        dp[start][fuel] = 1;

        for (int f = fuel; f >= 0; --f) {
            for (int i = 0; i < n; ++i) {
                if (dp[i][f] > 0) {
                    for (int j = 0; j < n; ++j) {
                        if (i != j) {
                            int cost = abs(locations[i] - locations[j]);
                            if (f >= cost) {
                                dp[j][f - cost] = (dp[j][f - cost] + dp[i][f]) % MOD;
                            }
                        }
                    }
                }
            }
        }

        int ans = 0;
        for (int f = 0; f <= fuel; ++f) {
            ans = (ans + dp[finish][f]) % MOD;
        }

        return ans;
    }
};