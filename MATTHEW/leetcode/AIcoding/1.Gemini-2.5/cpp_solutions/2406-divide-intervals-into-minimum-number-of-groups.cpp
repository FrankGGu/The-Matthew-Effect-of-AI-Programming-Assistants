#include <vector>
#include <algorithm>
#include <utility> // For std::pair

class Solution {
public:
    int minGroups(std::vector<std::vector<int>>& intervals) {
        std::vector<std::pair<int, int>> events;
        for (const auto& interval : intervals) {
            events.push_back({interval[0], 1}); // Start event: +1 to overlap count
            events.push_back({interval[1], -1}); // End event: -1 to overlap count
        }

        // Sort events:
        // 1. Primary sort key: coordinate (ascending).
        // 2. Secondary sort key: event type (descending).
        //    This means for events at the same coordinate, start events (type 1)
        //    are processed before end events (type -1).
        //    This handles the case where an interval ends at 'x' and another starts at 'x'.
        //    They are considered overlapping at 'x', so the start event should increment
        //    the count before the end event decrements it, ensuring the maximum overlap
        //    at 'x' is correctly captured.
        std::sort(events.begin(), events.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            if (a.first != b.first) {
                return a.first < b.first;
            }
            return a.second > b.second; 
        });

        int current_overlap = 0;
        int max_overlap = 0;

        for (const auto& event : events) {
            current_overlap += event.second;
            max_overlap = std::max(max_overlap, current_overlap);
        }

        return max_overlap;
    }
};