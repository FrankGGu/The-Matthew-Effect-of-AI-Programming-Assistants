#include <math.h>
#include <stdlib.h>

int* bestCoordinate(int** towers, int towersSize, int* towersColSize, int radius, int* returnSize) {
    *returnSize = 2;
    int* res = (int*)malloc(2 * sizeof(int));
    res[0] = 0;
    res[1] = 0;

    int minX = 50, maxX = 0, minY = 50, maxY = 0;
    for (int i = 0; i < towersSize; i++) {
        if (towers[i][0] < minX) minX = towers[i][0];
        if (towers[i][0] > maxX) maxX = towers[i][0];
        if (towers[i][1] < minY) minY = towers[i][1];
        if (towers[i][1] > maxY) maxY = towers[i][1];
    }

    double maxQuality = 0;
    for (int x = minX; x <= maxX; x++) {
        for (int y = minY; y <= maxY; y++) {
            double quality = 0;
            for (int i = 0; i < towersSize; i++) {
                int tx = towers[i][0];
                int ty = towers[i][1];
                double d = sqrt((tx - x) * (tx - x) + (ty - y) * (ty - y));
                if (d <= radius) {
                    quality += floor(towers[i][2] / (1 + d));
                }
            }
            if (quality > maxQuality) {
                maxQuality = quality;
                res[0] = x;
                res[1] = y;
            } else if (fabs(quality - maxQuality) < 1e-6) {
                if (x < res[0] || (x == res[0] && y < res[1])) {
                    res[0] = x;
                    res[1] = y;
                }
            }
        }
    }

    if (maxQuality == 0) {
        res[0] = 0;
        res[1] = 0;
    }

    return res;
}