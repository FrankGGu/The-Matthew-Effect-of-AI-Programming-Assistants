#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        int n = points.size();
        if (n <= 1) return n;
        int maxCount = 1;

        for (int i = 0; i < n; ++i) {
            unordered_map<double, int> slopeCount;
            int samePoint = 0;
            int localMax = 1;

            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                if (points[i][0] == points[j][0] && points[i][1] == points[j][1]) {
                    samePoint++;
                    continue;
                }
                double slope;
                if (points[i][0] == points[j][0]) {
                    slope = numeric_limits<double>::infinity();
                } else {
                    slope = (double)(points[j][1] - points[i][1]) / (points[j][0] - points[i][0]);
                }
                slopeCount[slope]++;
                localMax = max(localMax, slopeCount[slope] + 1);
            }
            maxCount = max(maxCount, localMax + samePoint);
        }

        return maxCount;
    }
};