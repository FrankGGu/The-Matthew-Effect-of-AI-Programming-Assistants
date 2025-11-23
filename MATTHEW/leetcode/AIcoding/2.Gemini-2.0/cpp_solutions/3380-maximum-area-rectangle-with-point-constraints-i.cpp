#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int solve(vector<vector<int>>& points) {
        int n = points.size();
        int maxArea = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;

                int x1 = min(points[i][0], points[j][0]);
                int y1 = min(points[i][1], points[j][1]);
                int x2 = max(points[i][0], points[j][0]);
                int y2 = max(points[i][1], points[j][1]);

                bool valid = true;
                for (int k = 0; k < n; ++k) {
                    if (points[k][0] > x1 && points[k][0] < x2 && points[k][1] > y1 && points[k][1] < y2) {
                        valid = false;
                        break;
                    }
                }

                if (valid) {
                    maxArea = max(maxArea, (x2 - x1) * (y2 - y1));
                }
            }
        }

        return maxArea;
    }
};