#include <iostream>
#include <vector>
#include <cmath>
#include <limits>

using namespace std;

class Solution {
public:
    vector<int> bestCoordinate() {
        int n = 0;
        cin >> n;
        vector<vector<int>> towers(n, vector<int>(3));
        for (int i = 0; i < n; ++i) {
            cin >> towers[i][0] >> towers[i][1] >> towers[i][2];
        }

        int maxQuality = 0;
        vector<int> bestCoord = {0, 0};

        for (int x = 0; x <= 50; ++x) {
            for (int y = 0; y <= 50; ++y) {
                int quality = 0;
                for (const auto& tower : towers) {
                    int tx = tower[0], ty = tower[1], tq = tower[2];
                    int dx = abs(x - tx), dy = abs(y - ty);
                    int dist = dx + dy;
                    if (dist == 0) {
                        quality += tq;
                    } else {
                        quality += tq / (1 + dist);
                    }
                }
                if (quality > maxQuality) {
                    maxQuality = quality;
                    bestCoord = {x, y};
                } else if (quality == maxQuality && (x < bestCoord[0] || (x == bestCoord[0] && y < bestCoord[1]))) {
                    bestCoord = {x, y};
                }
            }
        }

        return bestCoord;
    }
};