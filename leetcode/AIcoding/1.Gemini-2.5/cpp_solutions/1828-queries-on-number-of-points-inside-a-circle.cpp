#include <vector>

class Solution {
public:
    std::vector<int> countPoints(std::vector<std::vector<int>>& points, std::vector<std::vector<int>>& queries) {
        std::vector<int> ans;
        ans.reserve(queries.size());

        for (const auto& query : queries) {
            int cx = query[0];
            int cy = query[1];
            int r = query[2];
            int r_squared = r * r;
            int count = 0;

            for (const auto& point : points) {
                int px = point[0];
                int py = point[1];
                int dx = px - cx;
                int dy = py - cy;

                if (dx * dx + dy * dy <= r_squared) {
                    count++;
                }
            }
            ans.push_back(count);
        }

        return ans;
    }
};