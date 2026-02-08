#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxManhattanDistance(vector<vector<int>>& points, int k) {
        int n = points.size();
        int maxDist = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
                int minChanges = min({abs(points[i][0] - points[j][0]), abs(points[i][1] - points[j][1]), k});

                if (k >= abs(points[i][0] - points[j][0]))
                {
                    int rem = k - abs(points[i][0] - points[j][0]);
                    maxDist = max(maxDist, abs(points[i][1] - points[j][1]) + rem);
                }
                if (k >= abs(points[i][1] - points[j][1]))
                {
                    int rem = k - abs(points[i][1] - points[j][1]);
                    maxDist = max(maxDist, abs(points[i][0] - points[j][0]) + rem);
                }

                maxDist = max(maxDist, dist + k);
            }
        }

        if(points.size() == 1) return k;

        int max_x_plus_y = INT_MIN;
        int min_x_plus_y = INT_MAX;
        int max_x_minus_y = INT_MIN;
        int min_x_minus_y = INT_MAX;

        for(auto& p : points){
            max_x_plus_y = max(max_x_plus_y, p[0] + p[1]);
            min_x_plus_y = min(min_x_plus_y, p[0] + p[1]);
            max_x_minus_y = max(max_x_minus_y, p[0] - p[1]);
            min_x_minus_y = min(min_x_minus_y, p[0] - p[1]);
        }

        maxDist = max({maxDist, max_x_plus_y - min_x_plus_y + k, max_x_minus_y - min_x_minus_y + k});

        return maxDist;
    }
};