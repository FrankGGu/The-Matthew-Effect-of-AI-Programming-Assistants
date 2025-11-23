#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    double maxDistance(vector<vector<int>>& points) {
        int n = points.size();
        double maxDist = 0.0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                double dx = points[i][0] - points[j][0];
                double dy = points[i][1] - points[j][1];
                double dist = sqrt(dx * dx + dy * dy);
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
        }
        return maxDist;
    }
};