#include <vector>
#include <algorithm>
#include <utility> // For std::pair

struct Job {
    int start;
    int end;
    int profit;
};

class Solution {
public:
    int maxProfit(std::vector<int>& startTime, std::vector<int>& endTime, std::vector<int>& profit) {
        int n = startTime.size();
        std::vector<Job> jobs(n);
        for (int i = 0; i < n; ++i) {
            jobs[i] = {startTime[i], endTime[i], profit[i]};
        }

        // Sort jobs by their end times
        std::sort(jobs.begin(), jobs.end(), [](const Job& a, const Job& b) {
            return a.end < b.end;
        });

        // dp vector stores pairs of (end_time, max_profit_up_to_this_end_time)
        // The max_profit_up_to_this_end_time is always non-decreasing.
        // The end_time is strictly increasing.
        std::vector<std::pair<int, int>> dp;
        dp.push_back({0, 0}); // Base case: 0 profit at time 0

        for (const auto& job : jobs) {
            // Find the latest job in dp that finishes before or at job.start
            // std::upper_bound returns an iterator to the first element that is greater than the value.
            // We are looking for (end_time, profit) where end_time <= job.start.
            // So, we search for (job.start, -1) to find the first element (e, p) such that e > job.start.
            // Then, we decrement the iterator to get the element (e', p') where e' <= job.start.
            auto it = std::upper_bound(dp.begin(), dp.end(), std::make_pair(job.start, -1));
            --it; // 'it' now points to the pair (prev_end_time, prev_max_profit)
                  // where prev_end_time <= job.start

            int current_total_profit = job.profit + it->second;

            // If the current total profit is greater than the maximum profit achieved so far
            // (which is dp.back().second), then we add this new state to dp.
            // Otherwise, we don't add it because we already have a better or equal profit
            // for an earlier or same end time.
            if (current_total_profit > dp.back().second) {
                dp.push_back({job.end, current_total_profit});
            }
        }

        return dp.back().second;
    }
};