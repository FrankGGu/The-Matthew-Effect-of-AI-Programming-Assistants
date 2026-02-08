#include <vector>
#include <set>
#include <algorithm>
#include <limits>

class Solution {
public:
    bool isRectangleCover(std::vector<std::vector<int>>& rectangles) {
        if (rectangles.empty()) {
            return false;
        }

        long long totalArea = 0;
        int minX = std::numeric_limits<int>::max();
        int minY = std::numeric_limits<int>::max();
        int maxX = std::numeric_limits<int>::min();
        int maxY = std::numeric_limits<int>::min();

        std::set<std::pair<int, int>> points;

        for (const auto& rect : rectangles) {
            int x1 = rect[0];
            int y1 = rect[1];
            int x2 = rect[2];
            int y2 = rect[3];

            minX = std::min(minX, x1);
            minY = std::min(minY, y1);
            maxX = std::max(maxX, x2);
            maxY = std::max(maxY, y2);

            totalArea += (long long)(x2 - x1) * (y2 - y1);

            auto togglePoint = [&](int x, int y) {
                std::pair<int, int> p = {x, y};
                if (points.count(p)) {
                    points.erase(p);
                } else {
                    points.insert(p);
                }
            };

            togglePoint(x1, y1);
            togglePoint(x1, y2);
            togglePoint(x2, y1);
            togglePoint(x2, y2);
        }

        if (points.size() != 4) {
            return false;
        }

        if (!points.count({minX, minY}) ||
            !points.count({minX, maxY}) ||
            !points.count({maxX, minY}) ||
            !points.count({maxX, maxY})) {
            return false;
        }

        if (totalArea != (long long)(maxX - minX) * (maxY - minY)) {
            return false;
        }

        return true;
    }
};