#include <vector>

class Solution {
public:
    int numberOfWays(std::vector<std::vector<int>>& points) {
        int count = 0;
        int n = points.size();

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) {
                    continue;
                }

                if (points[i][0] >= points[j][0] && points[i][1] <= points[j][1]) {
                    count++;
                }
            }
        }

        return count;
    }
};