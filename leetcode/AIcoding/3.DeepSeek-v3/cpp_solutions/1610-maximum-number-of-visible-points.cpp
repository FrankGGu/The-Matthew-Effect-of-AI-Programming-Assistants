#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int visiblePoints(vector<vector<int>>& points, int angle, vector<int>& location) {
        int same = 0;
        vector<double> angles;
        for (const auto& p : points) {
            int dx = p[0] - location[0];
            int dy = p[1] - location[1];
            if (dx == 0 && dy == 0) {
                same++;
                continue;
            }
            double theta = atan2(dy, dx) * 180 / M_PI;
            angles.push_back(theta);
        }
        sort(angles.begin(), angles.end());
        int n = angles.size();
        for (int i = 0; i < n; ++i) {
            angles.push_back(angles[i] + 360);
        }
        int max_cnt = 0;
        for (int i = 0, j = 0; j < angles.size(); ++j) {
            while (angles[j] - angles[i] > angle) {
                i++;
            }
            max_cnt = max(max_cnt, j - i + 1);
        }
        return max_cnt + same;
    }
};