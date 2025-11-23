#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minAreaRect(vector<vector<int>>& points) {
        int n = points.size();
        if (n < 4) return 0;

        unordered_set<int> pointSet;
        for (auto& p : points) {
            pointSet.insert(p[0] * 40001 + p[1]);
        }

        int minArea = INT_MAX;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int x1 = points[i][0], y1 = points[i][1];
                int x2 = points[j][0], y2 = points[j][1];

                if (x1 == x2 || y1 == y2) continue;

                if (pointSet.count(x1 * 40001 + y2) && pointSet.count(x2 * 40001 + y1)) {
                    int area = abs(x1 - x2) * abs(y1 - y2);
                    minArea = min(minArea, area);
                }
            }
        }

        return (minArea == INT_MAX) ? 0 : minArea;
    }
};