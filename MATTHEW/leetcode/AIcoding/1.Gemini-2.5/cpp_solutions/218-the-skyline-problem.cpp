#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    std::vector<std::vector<int>> getSkyline(std::vector<std::vector<int>>& buildings) {
        std::vector<std::vector<int>> events;
        for (const auto& b : buildings) {
            events.push_back({b[0], -b[2]}); // Start event: [x, -height]
            events.push_back({b[1], b[2]});  // End event: [x, +height]
        }

        std::sort(events.begin(), events.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[0] != b[0]) {
                return a[0] < b[0];
            }
            return a[1] < b[1];
        });

        std::multiset<int> active_heights;
        active_heights.insert(0); // Ground level

        std::vector<std::vector<int>> result;
        int prev_max_h = 0;

        for (const auto& event : events) {
            int x = event[0];
            int h_val = event[1];

            if (h_val < 0) { // Start event
                active_heights.insert(-h_val);
            } else { // End event
                active_heights.erase(active_heights.find(h_val));
            }

            int current_max_h = *active_heights.rbegin();

            if (current_max_h != prev_max_h) {
                result.push_back({x, current_max_h});
                prev_max_h = current_max_h;
            }
        }

        return result;
    }
};