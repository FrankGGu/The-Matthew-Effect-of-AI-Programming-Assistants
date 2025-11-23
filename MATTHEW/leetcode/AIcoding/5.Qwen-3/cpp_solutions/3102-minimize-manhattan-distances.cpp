#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDistance(vector<vector<int>>& points) {
        int n = points.size();
        int minDist = INT_MAX;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
                minDist = min(minDist, dist);
            }
        }

        return minDist;
    }
};