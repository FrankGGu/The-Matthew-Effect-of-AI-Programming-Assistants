#include <vector>
#include <set>
#include <utility>

class Solution {
public:
    int countLatticePoints(std::vector<std::vector<int>>& circles) {
        std::set<std::pair<int, int>> points;
        for (const auto& circle : circles) {
            int cx = circle[0];
            int cy = circle[1];
            int r = circle[2];
            int r_squared = r * r;
            for (int px = cx - r; px <= cx + r; ++px) {
                for (int py = cy - r; py <= cy + r; ++py) {
                    if ((px - cx) * (px - cx) + (py - cy) * (py - cy) <= r_squared) {
                        points.insert({px, py});
                    }
                }
            }
        }
        return points.size();
    }
};