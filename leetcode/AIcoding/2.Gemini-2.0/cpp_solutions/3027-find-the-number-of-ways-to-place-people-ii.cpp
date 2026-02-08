#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfWays(vector<vector<int>>& points) {
        int n = points.size();
        sort(points.begin(), points.end(), [](const vector<int>& a, const vector<int>& b) {
            if (a[0] == b[0]) {
                return a[1] < b[1];
            }
            return a[0] < b[0];
        });

        long long count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                if (points[j][0] >= points[i][0] && points[j][1] <= points[i][1]) {
                    bool valid = true;
                    for (int k = 0; k < n; ++k) {
                        if (k == i || k == j) continue;
                        if (points[k][0] >= points[i][0] && points[k][0] <= points[j][0] && points[k][1] >= points[j][1] && points[k][1] <= points[i][1]) {
                            valid = false;
                            break;
                        }
                    }
                    if (valid) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
};