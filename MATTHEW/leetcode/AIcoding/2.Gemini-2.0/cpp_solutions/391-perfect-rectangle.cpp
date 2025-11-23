#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    bool isRectangleCover(vector<vector<int>>& rectangles) {
        if (rectangles.empty()) return true;

        int area = 0;
        int minX = INT_MAX, minY = INT_MAX, maxX = INT_MIN, maxY = INT_MIN;
        set<pair<int, int>> corners;

        for (auto& rect : rectangles) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            area += (x2 - x1) * (y2 - y1);

            minX = min(minX, x1);
            minY = min(minY, y1);
            maxX = max(maxX, x2);
            maxY = max(maxY, y2);

            pair<int, int> p1 = {x1, y1}, p2 = {x1, y2}, p3 = {x2, y1}, p4 = {x2, y2};

            if (corners.count(p1)) corners.erase(p1); else corners.insert(p1);
            if (corners.count(p2)) corners.erase(p2); else corners.insert(p2);
            if (corners.count(p3)) corners.erase(p3); else corners.insert(p3);
            if (corners.count(p4)) corners.erase(p4); else corners.insert(p4);
        }

        if (corners.size() != 4 ||
            !corners.count({minX, minY}) ||
            !corners.count({minX, maxY}) ||
            !corners.count({maxX, minY}) ||
            !corners.count({maxX, maxY})) {
            return false;
        }

        return area == (maxX - minX) * (maxY - minY);
    }
};