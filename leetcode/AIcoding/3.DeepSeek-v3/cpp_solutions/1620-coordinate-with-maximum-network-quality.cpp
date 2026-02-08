#include <vector>
#include <cmath>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> bestCoordinate(vector<vector<int>>& towers, int radius) {
        int minX = INT_MAX, minY = INT_MAX;
        int maxX = INT_MIN, maxY = INT_MIN;
        for (const auto& tower : towers) {
            minX = min(minX, tower[0]);
            minY = min(minY, tower[1]);
            maxX = max(maxX, tower[0]);
            maxY = max(maxY, tower[1]);
        }

        vector<int> bestCoord = {0, 0};
        int maxQuality = 0;

        for (int x = minX; x <= maxX; ++x) {
            for (int y = minY; y <= maxY; ++y) {
                int quality = 0;
                for (const auto& tower : towers) {
                    int dx = x - tower[0];
                    int dy = y - tower[1];
                    double dist = sqrt(dx * dx + dy * dy);
                    if (dist <= radius) {
                        quality += floor(tower[2] / (1 + dist));
                    }
                }
                if (quality > maxQuality) {
                    maxQuality = quality;
                    bestCoord = {x, y};
                } else if (quality == maxQuality) {
                    if (x < bestCoord[0] || (x == bestCoord[0] && y < bestCoord[1])) {
                        bestCoord = {x, y};
                    }
                }
            }
        }

        return bestCoord;
    }
};