#include <vector>

class Solution {
public:
    int numberWays(std::vector<std::vector<int>>& hats) {
        int n = hats.size();
        int mod = 1e9 + 7;

        std::vector<std::vector<int>> hat_to_people(41);
        for (int i = 0; i < n; ++i) {
            for (int h : hats[i]) {
                hat_to_people[h].push_back(i);
            }
        }

        std::vector<int> dp(1 << n, 0);
        dp[0] = 1;

        for (int h = 1; h <= 40; ++h) {
            for (int mask = (1 << n) - 1; mask >= 0; --mask) {
                for (int p : hat_to_people[h]) {
                    if ((mask >> p) & 1) {
                        int prev_mask = mask ^ (1 << p);
                        dp[mask] = (dp[mask] + dp[prev_mask]) % mod;
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};