#include <vector>
#include <algorithm>

bool compareEvents(const std::vector<int>& a, const std::vector<int>& b) {
    if (a[1] != b[1]) {
        return a[1] < b[1];
    }
    return a[0] < b[0];
}

class Solution {
public:
    long long findNumberOfPossibleWaysForAnEvent(std::vector<std::vector<int>>& events) {
        if (events.empty()) {
            return 1;
        }

        std::sort(events.begin(), events.end(), compareEvents);

        int n = events.size();
        std::vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            const auto& current_event = events[i-1];

            dp[i] = dp[i-1];

            auto it = std::upper_bound(events.begin(), events.begin() + (i - 1), current_event[0], 
                                       [](int val, const std::vector<int>& event) {
                                           return val < event[1];
                                       });

            int prev_idx = (it - events.begin()) - 1;

            long long ways_from_compatible_prev_events = (prev_idx >= 0) ? dp[prev_idx + 1] : dp[0];

            dp[i] += ways_from_compatible_prev_events;
        }

        return dp[n];
    }
};