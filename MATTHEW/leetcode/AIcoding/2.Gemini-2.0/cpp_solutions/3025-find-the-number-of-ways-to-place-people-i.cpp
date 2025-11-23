#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfWays(vector<vector<int>>& points) {
        sort(points.begin(), points.end());
        int n = points.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (points[j][1] >= points[i][1]) {
                    count++;
                }
            }
        }
        return count;
    }
};