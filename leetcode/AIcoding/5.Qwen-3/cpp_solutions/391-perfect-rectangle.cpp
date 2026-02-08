#include <iostream>
#include <vector>
#include <set>
#include <utility>

using namespace std;

class Solution {
public:
    bool isPerfectRectangle(vector<vector<int>>& rectangles) {
        set<pair<int, int>> points;
        int area = 0;
        int min_x = INT_MAX, min_y = INT_MAX, max_x = INT_MIN, max_y = INT_MIN;

        for (const auto& rect : rectangles) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            min_x = min(min_x, x1);
            min_y = min(min_y, y1);
            max_x = max(max_x, x2);
            max_y = max(max_y, y2);

            area += (x2 - x1) * (y2 - y1);

            for (const auto& p : {make_pair(x1, y1), make_pair(x1, y2), make_pair(x2, y1), make_pair(x2, y2)}) {
                if (points.find(p) != points.end()) {
                    points.erase(p);
                } else {
                    points.insert(p);
                }
            }
        }

        if (points.size() != 4) return false;
        if (area != (max_x - min_x) * (max_y - min_y)) return false;

        return true;
    }
};