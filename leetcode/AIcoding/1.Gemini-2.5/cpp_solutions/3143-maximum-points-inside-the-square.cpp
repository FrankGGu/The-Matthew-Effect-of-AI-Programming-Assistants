#include <vector>
#include <algorithm>
#include <map>
#include <cmath> // For std::abs

class Solution {
public:
    int maxPointsInsideTheSquare(std::vector<std::vector<int>>& points, std::vector<int>& tags) {
        std::map<int, std::vector<int>> tag_radii;
        for (int i = 0; i < points.size(); ++i) {
            int x = points[i][0];
            int y = points[i][1];
            int tag = tags[i];
            int r = std::max(std::abs(x), std::abs(y));
            tag_radii[tag].push_back(r);
        }

        std::vector<int> second_smallest_radii;
        for (auto const& pair : tag_radii) {
            const std::vector<int>& radii_list = pair.second;
            if (radii_list.size() >= 2) {
                std::vector<int> sorted_radii = radii_list;
                std::sort(sorted_radii.begin(), sorted_radii.end());
                second_smallest_radii.push_back(sorted_radii[1]);
            }
        }

        if (second_smallest_radii.empty()) {
            return 1000000000; 
        } else {
            int min_second_r = second_smallest_radii[0];
            for (size_t i = 1; i < second_smallest_radii.size(); ++i) {
                if (second_smallest_radii[i] < min_second_r) {
                    min_second_r = second_smallest_radii[i];
                }
            }

            return std::max(0, min_second_r - 1);
        }
    }
};