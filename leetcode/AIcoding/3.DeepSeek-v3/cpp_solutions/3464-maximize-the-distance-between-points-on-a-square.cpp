#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxDist(int n, vector<vector<int>>& points) {
        int minX = INT_MAX, maxX = INT_MIN;
        int minY = INT_MAX, maxY = INT_MIN;

        for (const auto& p : points) {
            minX = min(minX, p[0]);
            maxX = max(maxX, p[0]);
            minY = min(minY, p[1]);
            maxY = max(maxY, p[1]);
        }

        int side = max(maxX - minX, maxY - minY);

        int maxDist = 0;
        for (const auto& p : points) {
            int dist = max({
                abs(p[0] - minX) + abs(p[1] - minY),
                abs(p[0] - minX) + abs(p[1] - maxY),
                abs(p[0] - maxX) + abs(p[1] - minY),
                abs(p[0] - maxX) + abs(p[1] - maxY)
            });
            maxDist = max(maxDist, dist);
        }

        return maxDist;
    }
};