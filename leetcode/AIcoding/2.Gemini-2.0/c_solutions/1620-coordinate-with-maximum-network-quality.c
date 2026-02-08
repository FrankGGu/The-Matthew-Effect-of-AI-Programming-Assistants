#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int bestCoordinate(int** towers, int towersSize, int* towersColSize, int radius) {
    int minX = 100, minY = 100, maxX = 0, maxY = 0;
    for (int i = 0; i < towersSize; i++) {
        minX = fmin(minX, towers[i][0]);
        minY = fmin(minY, towers[i][1]);
        maxX = fmax(maxX, towers[i][0]);
        maxY = fmax(maxY, towers[i][1]);
    }

    int bestX = 0, bestY = 0, maxQuality = 0;
    for (int x = 0; x <= maxX; x++) {
        for (int y = 0; y <= maxY; y++) {
            int quality = 0;
            for (int i = 0; i < towersSize; i++) {
                double dist = sqrt(pow(x - towers[i][0], 2) + pow(y - towers[i][1], 2));
                if (dist <= radius) {
                    quality += (int)(towers[i][2] / (1 + dist));
                }
            }

            if (quality > maxQuality) {
                maxQuality = quality;
                bestX = x;
                bestY = y;
            }
        }
    }

    return bestX * 101 + bestY;
}