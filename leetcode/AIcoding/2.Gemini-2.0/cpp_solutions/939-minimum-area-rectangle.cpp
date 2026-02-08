#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minAreaRect(vector<vector<int>>& points) {
        int n = points.size();
        int min_area = 0;
        unordered_set<int> point_set;

        for (auto& point : points) {
            point_set.insert(point[0] * 40001 + point[1]);
        }

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int x1 = points[i][0];
                int y1 = points[i][1];
                int x2 = points[j][0];
                int y2 = points[j][1];

                if (x1 != x2 && y1 != y2) {
                    if (point_set.count(x1 * 40001 + y2) && point_set.count(x2 * 40001 + y1)) {
                        int area = abs(x1 - x2) * abs(y1 - y2);
                        if (min_area == 0 || area < min_area) {
                            min_area = area;
                        }
                    }
                }
            }
        }

        return min_area;
    }
};