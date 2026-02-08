#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int visiblePoints(vector<vector<int>>& points, int angle) {
        vector<double> angles;
        int x = 0, y = 0;
        for (auto& p : points) {
            x = p[0];
            y = p[1];
            if (x == 0 && y == 0) continue;
            angles.push_back(atan2(y, x) * 180 / M_PI);
        }
        sort(angles.begin(), angles.end());
        int n = angles.size();
        for (int i = 0; i < n; ++i) {
            angles.push_back(angles[i] + 360);
        }
        int res = 0, j = 0;
        for (int i = 0; i < n; ++i) {
            while (j < 2 * n && angles[j] - angles[i] <= angle) ++j;
            res = max(res, j - i);
        }
        return res;
    }
};