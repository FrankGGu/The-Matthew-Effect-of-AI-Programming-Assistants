#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxAreaRectWithPoint(vector<vector<int>>& points, int x, int y) {
        unordered_set<string> pointSet;
        for (const auto& p : points) {
            pointSet.insert(to_string(p[0]) + "," + to_string(p[1]));
        }

        int maxArea = 0;
        int n = points.size();

        for (int i = 0; i < n; ++i) {
            int x1 = points[i][0], y1 = points[i][1];
            for (int j = i + 1; j < n; ++j) {
                int x2 = points[j][0], y2 = points[j][1];
                if (x1 != x2 && y1 != y2) {
                    if (pointSet.count(to_string(x1) + "," + to_string(y2)) && 
                        pointSet.count(to_string(x2) + "," + to_string(y1))) {
                        if ((x == x1 && y == y1) || (x == x2 && y == y2) || 
                            (x == x1 && y == y2) || (x == x2 && y == y1)) {
                            int area = abs(x1 - x2) * abs(y1 - y2);
                            if (area > maxArea) {
                                maxArea = area;
                            }
                        }
                    }
                }
            }
        }

        return maxArea;
    }
};