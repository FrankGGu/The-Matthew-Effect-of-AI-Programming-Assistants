#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberWays(vector<vector<int>>& hats) {
        int n = hats.size();
        unordered_map<int, vector<int>> hatToPeople;
        for (int i = 0; i < n; ++i) {
            for (int h : hats[i]) {
                hatToPeople[h].push_back(i);
            }
        }

        vector<vector<int>> dp(1 << n, vector<int>(n + 1, 0));
        dp[0][0] = 1;

        for (int h = 1; h <= 100; ++h) {
            if (hatToPeople.find(h) == hatToPeople.end()) continue;
            vector<int> people = hatToPeople[h];
            for (int mask = 0; mask < (1 << n); ++mask) {
                for (int k = 0; k <= n; ++k) {
                    dp[mask][k] = dp[mask][k];
                }
            }

            for (int mask = 0; mask < (1 << n); ++mask) {
                for (int k = 0; k < n; ++k) {
                    if (dp[mask][k] == 0) continue;
                    for (int p : people) {
                        if ((mask & (1 << p)) == 0) {
                            int new_mask = mask | (1 << p);
                            dp[new_mask][k + 1] += dp[mask][k];
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int k = 0; k <= n; ++k) {
            result += dp[(1 << n) - 1][k];
        }

        return result;
    }
};