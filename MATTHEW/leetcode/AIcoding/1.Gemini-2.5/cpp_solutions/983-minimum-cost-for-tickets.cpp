#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int mincostTickets(std::vector<int>& days, std::vector<int>& costs) {
        int max_day = days.back();

        std::vector<bool> is_travel_day(max_day + 1, false);
        for (int day : days) {
            is_travel_day[day] = true;
        }

        std::vector<int> dp(max_day + 1, 0);

        for (int d = 1; d <= max_day; ++d) {
            if (!is_travel_day[d]) {
                dp[d] = dp[d-1];
            } else {
                // Option 1: 1-day pass
                int cost1 = dp[d-1] + costs[0];

                // Option 2: 7-day pass
                // A 7-day pass bought on day `d'` covers days `d'` to `d'+6`.
                // If we buy a 7-day pass to cover day `d`, the latest day it could have been bought is `d-6`.
                // So we need to ensure all days up to `d-7` are covered, then add the 7-day pass cost.
                int cost7 = dp[std::max(0, d-7)] + costs[1];

                // Option 3: 30-day pass
                // Similarly for a 30-day pass, it could have been bought on day `d-29`.
                // We need to ensure all days up to `d-30` are covered, then add the 30-day pass cost.
                int cost30 = dp[std::max(0, d-30)] + costs[2];

                dp[d] = std::min({cost1, cost7, cost30});
            }
        }

        return dp[max_day];
    }
};