#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    double minAreaRect(std::vector<std::vector<int>>& points) {
        std::unordered_map<int, std::unordered_set<int>> pointSet;
        for (const auto& p : points) {
            pointSet[p[0]].insert(p[1]);
        }

        double minArea = std::numeric_limits<double>::max();
        for (int i = 0; i < points.size(); ++i) {
            for (int j = i + 1; j < points.size(); ++j) {
                if (points[i][0] != points[j][0] && points[i][1] != points[j][1]) {
                    if (pointSet[points[i][0]].count(points[j][1]) && 
                        pointSet[points[j][0]].count(points[i][1])) {
                        double area = static_cast<double>(std::abs(points[i][0] - points[j][0])) * 
                                       std::abs(points[i][1] - points[j][1]);
                        minArea = std::min(minArea, area);
                    }
                }
            }
        }

        return minArea == std::numeric_limits<double>::max() ? 0.0 : minArea;
    }
};