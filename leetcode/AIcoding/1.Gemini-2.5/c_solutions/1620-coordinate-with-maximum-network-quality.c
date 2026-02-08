#include <stdlib.h>
#include <math.h>

int* coordinateWithMaxNetworkQuality(int** towers, int towersSize, int* towersColSize, int radius, int* returnSize) {
    int max_quality = 0;
    int best_x = 0;
    int best_y = 0;

    // The problem constraints indicate x and y coordinates are between 0 and 50.
    int max_coord = 50; 

    for (int x = 0; x <= max_coord; ++x) {
        for (int y = 0; y <= max_coord; ++y) {
            int current_quality = 0;
            for (int i = 0; i < towersSize; ++i) {
                int tx = towers[i][0];
                int ty = towers[i][1];
                int tq = towers[i][2];

                int dx = x - tx;
                int dy = y - ty;
                double dist_sq = (double)(dx * dx + dy * dy);
                double radius_sq = (double)(radius * radius);

                if (dist_sq <= radius_sq) {
                    double d = sqrt(dist_sq);
                    current_quality += floor((double)tq / (1.0 + d));
                }
            }

            if (current_quality > max_quality) {
                max_quality = current_quality;
                best_x = x;
                best_y = y;
            } else if (current_quality == max_quality) {
                // Tie-breaking rules: smallest x, then smallest y
                if (x < best_x) {
                    best_x = x;
                    best_y = y;
                } else if (x == best_x && y < best_y) {
                    best_y = y;
                }
            }
        }
    }

    int* result = (int*)malloc(sizeof(int) * 2);
    result[0] = best_x;
    result[1] = best_y;
    *returnSize = 2;

    return result;
}