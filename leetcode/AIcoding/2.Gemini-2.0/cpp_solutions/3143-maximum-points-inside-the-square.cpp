#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPointsInsideSquare(vector<vector<int>>& points, int side) {
        int n = points.size();
        int max_count = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int x1 = points[i][0];
                int y1 = points[j][1];

                for (int k = 0; k < n; ++k) {
                    int count = 0;
                    for (int l = 0; l < n; ++l) {
                        if (points[l][0] >= x1 && points[l][0] <= x1 + side &&
                            points[l][1] >= y1 && points[l][1] <= y1 + side) {
                            count++;
                        }
                    }
                    max_count = max(max_count, count);
                }
            }
        }

        return max_count;
    }
};