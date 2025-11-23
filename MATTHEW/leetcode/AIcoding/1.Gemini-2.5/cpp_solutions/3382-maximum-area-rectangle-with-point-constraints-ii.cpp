#include <vector>
#include <algorithm>
#include <set>

struct Point {
    int x, y;
    bool operator<(const Point& other) const {
        if (x != other.x) {
            return x < other.x;
        }
        return y < other.y;
    }
};

class Solution {
public:
    long long maxArea(std::vector<std::vector<int>>& points_vec, int w) {
        std::vector<Point> points;
        for (const auto& p : points_vec) {
            points.push_back({p[0], p[1]});
        }

        std::sort(points.begin(), points.end());

        long long max_area = 0;
        std::multiset<int> y_coords;

        int left = 0;
        for (int right = 0; right < points.size(); ++right) {
            y_coords.insert(points[right].y);

            while (points[right].x - points[left].x > w) {
                y_coords.erase(y_coords.find(points[left].y));
                left++;
            }

            long long current_width = points[right].x - points[left].x;
            long long current_height = *y_coords.rbegin() - *y_coords.begin();
            max_area = std::max(max_area, current_width * current_height);
        }

        return max_area;
    }
};