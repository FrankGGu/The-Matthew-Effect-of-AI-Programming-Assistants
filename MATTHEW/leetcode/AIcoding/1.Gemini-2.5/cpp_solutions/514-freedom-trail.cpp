#include <string>
#include <vector>
#include <algorithm>
#include <cmath>
#include <climits>

class Solution {
public:
    int findRotateSteps(std::string ring, std::string key) {
        int n = ring.length();
        int m = key.length();

        std::vector<std::vector<int>> pos(26);
        for (int i = 0; i < n; ++i) {
            pos[ring[i] - 'a'].push_back(i);
        }

        std::vector<int> dp(n, INT_MAX);

        for (int p : pos[key[0] - 'a']) {
            dp[p] = std::min(p, n - p) + 1;
        }

        for (int i = 1; i < m; ++i) {
            std::vector<int> next_dp(n, INT_MAX);
            for (int curr_p : pos[key[i] - 'a']) {
                for (int prev_p : pos[key[i - 1] - 'a']) {
                    int dist = std::abs(curr_p - prev_p);
                    int step = std::min(dist, n - dist);
                    if (dp[prev_p] != INT_MAX) {
                        next_dp[curr_p] = std::min(next_dp[curr_p], dp[prev_p] + step + 1);
                    }
                }
            }
            dp = next_dp;
        }

        int min_steps = INT_MAX;
        for (int val : dp) {
            min_steps = std::min(min_steps, val);
        }

        return min_steps;
    }
};