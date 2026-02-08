#include <vector>
#include <utility>
#include <algorithm>

class Solution {
public:
    int minSessions(std::vector<int>& tasks, int sessionTime) {
        int n = tasks.size();
        int num_masks = 1 << n;

        std::vector<std::pair<int, int>> dp(num_masks, {n + 1, sessionTime + 1});
        dp[0] = {1, 0};

        for (int mask = 1; mask < num_masks; ++mask) {
            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) {
                    int prev_mask = mask ^ (1 << i);
                    auto [prev_sessions, prev_last_time] = dp[prev_mask];

                    if (prev_last_time + tasks[i] <= sessionTime) {
                        dp[mask] = std::min(dp[mask], {prev_sessions, prev_last_time + tasks[i]});
                    } else {
                        dp[mask] = std::min(dp[mask], {prev_sessions + 1, tasks[i]});
                    }
                }
            }
        }

        return dp[num_masks - 1].first;
    }
};