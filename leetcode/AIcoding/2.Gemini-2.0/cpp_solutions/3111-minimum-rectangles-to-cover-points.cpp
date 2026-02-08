#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minAreaRectangles(vector<vector<int>>& points) {
        int n = points.size();
        if (n < 4) return 0;

        int min_area = INT_MAX;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (points[i][0] == points[j][0] || points[i][1] == points[j][1]) continue;

                int x1 = points[i][0], y1 = points[i][1];
                int x2 = points[j][0], y2 = points[j][1];

                bool found1 = false, found2 = false;
                for (int k = 0; k < n; ++k) {
                    if (k == i || k == j) continue;
                    if (points[k][0] == x1 && points[k][1] == y2) found1 = true;
                    if (points[k][0] == x2 && points[k][1] == y1) found2 = true;
                }

                if (found1 && found2) {
                    int area = abs(x1 - x2) * abs(y1 - y2);
                    min_area = min(min_area, area);
                }
            }
        }

        return (min_area == INT_MAX) ? 0 : min_area;
    }
};