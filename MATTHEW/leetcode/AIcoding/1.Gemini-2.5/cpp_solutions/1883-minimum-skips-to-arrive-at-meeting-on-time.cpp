#include <vector>
#include <cmath>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minSkips(std::vector<int>& dist, int speed, int hoursBefore) {
        int n = dist.size();

        // dp[i][j] will store the minimum time to travel the first i roads
        // using j skips.
        // i ranges from 0 to n (number of roads processed).
        // j ranges from 0 to n-1 (number of skips used).
        // The last road (dist[n-1]) cannot effectively be skipped for waiting,
        // as there's no subsequent road to wait for.
        // So, max skips for waiting is n-1 (for roads 0 to n-2).
        std::vector<std::vector<long double>> dp(n + 1, std::vector<long double>(n, std::numeric_limits<long double>::max()));

        // Base case: 0 roads, 0 skips, 0 time.
        dp[0][0] = 0.0L;

        // Iterate through each road
        for (int i = 0; i < n; ++i) { // Current road is dist[i] (0-indexed)
            long double time_for_current_road = static_cast<long double>(dist[i]) / speed;

            // Iterate through possible number of skips used so far (j for roads 0 to i-1)
            // The number of skips j for i roads can be at most i.
            // Also, total skips cannot exceed n-1.
            for (int j = 0; j <= i && j < n; ++j) {
                if (dp[i][j] == std::numeric_limits<long double>::max()) {
                    continue; // This state is unreachable
                }

                // Option 1: Don't skip the current road (dist[i])
                // This means we use j skips for i+1 roads (same as for i roads).
                long double time_after_no_skip = dp[i][j] + time_for_current_road;
                if (i < n - 1) { // If it's not the last road, apply ceil
                    time_after_no_skip = std::ceil(time_after_no_skip);
                }
                dp[i + 1][j] = std::min(dp[i + 1][j], time_after_no_skip);

                // Option 2: Skip the current road (dist[i])
                // This means we use j+1 skips for i+1 roads.
                // This is only possible if we have skip budget left (j+1 < n).
                if (j + 1 < n) {
                    long double time_after_skip = dp[i][j] + time_for_current_road;
                    dp[i + 1][j + 1] = std::min(dp[i + 1][j + 1], time_after_skip);
                }
            }
        }

        // After processing all roads, check which number of skips meets the deadline
        for (int s = 0; s < n; ++s) {
            if (dp[n][s] <= hoursBefore + 1e-9L) { // Add a small epsilon for floating point comparison
                return s;
            }
        }

        return -1; // No number of skips allows arriving on time
    }
};