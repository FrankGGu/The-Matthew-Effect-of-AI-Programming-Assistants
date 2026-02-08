#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minDifficulty(std::vector<int>& jobDifficulty, int d) {
        int n = jobDifficulty.size();

        if (n < d) {
            return -1;
        }

        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(d + 1, std::numeric_limits<int>::max()));

        dp[0][0] = 0;

        for (int day = 1; day <= d; ++day) {
            for (int i = 1; i <= n; ++i) {
                if (i < day) {
                    continue;
                }

                int current_max_difficulty_on_last_day = 0;
                for (int p = i - 1; p >= day - 1; --p) {
                    current_max_difficulty_on_last_day = std::max(current_max_difficulty_on_last_day, jobDifficulty[p]);

                    if (dp[p][day - 1] != std::numeric_limits<int>::max()) {
                        dp[i][day] = std::min(dp[i][day], dp[p][day - 1] + current_max_difficulty_on_last_day);
                    }
                }
            }
        }

        if (dp[n][d] == std::numeric_limits<int>::max()) {
            return -1;
        } else {
            return dp[n][d];
        }
    }
};