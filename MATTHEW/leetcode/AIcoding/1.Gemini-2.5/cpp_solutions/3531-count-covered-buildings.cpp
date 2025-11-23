#include <vector>
#include <algorithm>

class Solution {
public:
    int countCoveredBuildings(std::vector<std::vector<int>>& buildings) {
        std::sort(buildings.begin(), buildings.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[0] != b[0]) {
                return a[0] < b[0];
            }
            return a[1] > b[1];
        });

        int uncovered_count = 0;
        int max_height_seen = -1;

        for (const auto& building : buildings) {
            int current_h = building[1];
            if (current_h > max_height_seen) {
                uncovered_count++;
                max_height_seen = current_h;
            }
        }

        return buildings.size() - uncovered_count;
    }
};