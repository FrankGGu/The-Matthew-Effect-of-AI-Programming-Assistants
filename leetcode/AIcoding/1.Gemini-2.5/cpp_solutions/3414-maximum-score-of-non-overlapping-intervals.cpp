#include <vector>
#include <algorithm>

class Solution {
public:
    long long maximumScore(std::vector<std::vector<int>>& intervals) {
        std::sort(intervals.begin(), intervals.end(), [](const auto& a, const auto& b) {
            return a[1] < b[1];
        });

        int n = intervals.size();
        if (n == 0) {
            return 0;
        }

        std::vector<long long> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            int start = intervals[i - 1][0];
            int score = intervals[i - 1][2];

            long long option1 = dp[i - 1];

            auto it = std::lower_bound(intervals.begin(), intervals.begin() + i - 1, start, 
                                       [](const std::vector<int>& interval, int val) {
                                           return interval[1] < val;
                                       });

            int p = std::distance(intervals.begin(), it) - 1;

            long long prev_score = (p < 0) ? 0 : dp[p + 1];
            long long option2 = score + prev_score;

            dp[i] = std::max(option1, option2);
        }

        return dp[n];
    }
};