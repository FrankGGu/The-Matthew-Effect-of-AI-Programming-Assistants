#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    std::vector<int> coordinateWithMaxNetworkQuality(std::vector<std::vector<int>>& towers, int radius) {
        std::vector<int> result = {0, 0};
        int max_quality = 0;

        // The maximum possible coordinate value for a tower is 100.
        // The maximum radius is 100.
        // So, the relevant search space for x and y coordinates is from 0 to 100 + 100 = 200.
        // Any point outside this range would be too far from any tower to contribute quality.
        for (int x = 0; x <= 200; ++x) {
            for (int y = 0; y <= 200; ++y) {
                int current_quality = 0;
                for (const auto& tower : towers) {
                    int tx = tower[0];
                    int ty = tower[1];
                    int tq = tower[2];

                    double dist_sq = static_cast<double>((x - tx) * (x - tx)) + static_cast<double>((y - ty) * (y - ty));
                    double dist = std::sqrt(dist_sq);

                    if (dist <= radius) {
                        current_quality += static_cast<int>(std::floor(tq / (1 + dist)));
                    }
                }

                // Update max_quality and result based on tie-breaking rules
                if (current_quality > max_quality) {
                    max_quality = current_quality;
                    result[0] = x;
                    result[1] = y;
                } else if (current_quality == max_quality) {
                    if (x < result[0]) {
                        result[0] = x;
                        result[1] = y;
                    } else if (x == result[0] && y < result[1]) {
                        result[1] = y;
                    }
                }
            }
        }

        return result;
    }
};