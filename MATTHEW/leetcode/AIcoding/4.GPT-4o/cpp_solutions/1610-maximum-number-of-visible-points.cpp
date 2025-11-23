#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int visiblePoints(vector<vector<int>>& points, int angle, vector<int>& location) {
        vector<double> angles;
        for (const auto& point : points) {
            if (point[0] == location[0] && point[1] == location[1]) {
                continue;
            }
            double theta = atan2(point[1] - location[1], point[0] - location[0]) * 180 / M_PI;
            angles.push_back(theta);
        }

        sort(angles.begin(), angles.end());
        int n = angles.size();
        for (int i = 0; i < n; ++i) {
            angles.push_back(angles[i] + 360);
        }

        int maxVisible = 0;
        int j = 0;
        for (int i = 0; i < n; ++i) {
            while (j < angles.size() && angles[j] - angles[i] <= angle) {
                j++;
            }
            maxVisible = max(maxVisible, j - i);
        }

        return maxVisible + 1; // +1 for the point at the location
    }
};