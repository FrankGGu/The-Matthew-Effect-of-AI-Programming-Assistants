#include <vector>
#include <unordered_map>

class Solution {
public:
    int numberOfBoomerangs(std::vector<std::vector<int>>& points) {
        int result = 0;
        for (size_t i = 0; i < points.size(); ++i) {
            std::unordered_map<long, int> dist_map;
            for (size_t j = 0; j < points.size(); ++j) {
                if (i == j) {
                    continue;
                }
                long dx = points[i][0] - points[j][0];
                long dy = points[i][1] - points[j][1];
                long dist_sq = dx * dx + dy * dy;
                dist_map[dist_sq]++;
            }
            for (auto const& [dist, count] : dist_map) {
                result += count * (count - 1);
            }
        }
        return result;
    }
};