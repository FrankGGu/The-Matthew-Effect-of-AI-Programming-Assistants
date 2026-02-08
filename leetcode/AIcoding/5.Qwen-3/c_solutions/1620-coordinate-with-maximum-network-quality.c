#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int** maxNetworkQuality(int* towers, int towersSize, int radius, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int maxQuality = -1;
    int xMax = 0, yMax = 0;

    for (int x = 0; x <= 200; x++) {
        for (int y = 0; y <= 200; y++) {
            int quality = 0;
            for (int i = 0; i < towersSize; i += 3) {
                int tx = towers[i];
                int ty = towers[i + 1];
                int tq = towers[i + 2];
                double distance = sqrt((x - tx) * (x - tx) + (y - ty) * (y - ty));
                if (distance <= radius && tq > 0) {
                    quality += tq / (1 + distance);
                }
            }
            if (quality > maxQuality) {
                maxQuality = quality;
                xMax = x;
                yMax = y;
            } else if (quality == maxQuality) {
                if (x < xMax || (x == xMax && y < yMax)) {
                    xMax = x;
                    yMax = y;
                }
            }
        }
    }

    *returnSize = 1;
    *returnColumnSizes = (int*)malloc(sizeof(int));
    (*returnColumnSizes)[0] = 2;
    result[0] = (int*)malloc(2 * sizeof(int));
    result[0][0] = xMax;
    result[0][1] = yMax;

    return result;
}