#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int bestCoordinate(vector<vector<int>>& towers, int radius) {
        int maxQuality = -1;
        int bestX = 0, bestY = 0;

        int minX = towers[0][0], maxX = towers[0][0];
        int minY = towers[0][1], maxY = towers[0][1];

        for (const auto& tower : towers) {
            minX = min(minX, tower[0]);
            maxX = max(maxX, tower[0]);
            minY = min(minY, tower[1]);
            maxY = max(maxY, tower[1]);
        }

        for (int x = minX; x <= maxX; ++x) {
            for (int y = minY; y <= maxY; ++y) {
                int quality = 0;
                for (const auto& tower : towers) {
                    double dist = sqrt(pow(x - tower[0], 2) + pow(y - tower[1], 2));
                    if (dist <= radius) {
                        quality += floor(tower[2] / (1 + dist));
                    }
                }

                if (quality > maxQuality) {
                    maxQuality = quality;
                    bestX = x;
                    bestY = y;
                } else if (quality == maxQuality && (x < bestX || (x == bestX && y < bestY))) {
                    bestX = x;
                    bestY = y;
                }
            }
        }

        return bestX * 100 + bestY;
    }
};