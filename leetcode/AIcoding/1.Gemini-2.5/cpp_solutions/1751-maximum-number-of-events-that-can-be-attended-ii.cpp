#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> events_data;
    std::vector<int> start_times_data;
    std::vector<std::vector<long long>> memo;

    long long solve(int idx, int k_remaining) {
        if (k_remaining == 0 || idx == events_data.size()) {
            return 0;
        }
        if (memo[idx][k_remaining] != -1) {
            return memo[idx][k_remaining];
        }

        long long max_val = solve(idx + 1, k_remaining);

        long long current_event_value = events_data[idx][2];
        int current_event_end_time = events_data[idx][1];

        auto it = std::upper_bound(start_times_data.begin() + idx + 1, start_times_data.end(), current_event_end_time);
        int next_event_idx = std::distance(start_times_data.begin(), it);

        max_val = std::max(max_val, current_event_value + solve(next_event_idx, k_remaining - 1));

        return memo[idx][k_remaining] = max_val;
    }

    int maxEvents(std::vector<std::vector<int>>& events, int k) {
        std::sort(events.begin(), events.end());
        events_data = events;

        start_times_data.reserve(events.size());
        for (const auto& event : events) {
            start_times_data.push_back(event[0]);
        }

        memo.assign(events.size(), std::vector<long long>(k + 1, -1));

        return static_cast<int>(solve(0, k));
    }
};