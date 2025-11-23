#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxPointsInsideSquare(int** points, int pointsSize, int* pointsColSize, int side) {
    int maxCount = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < pointsSize; j++) {
            int x1 = points[i][0];
            int y1 = points[j][1];

            int count = 0;
            for (int k = 0; k < pointsSize; k++) {
                int x = points[k][0];
                int y = points[k][1];

                if (x >= x1 && x <= x1 + side && y >= y1 && y <= y1 + side) {
                    count++;
                }
            }
            if (count > maxCount) {
                maxCount = count;
            }
        }
    }
    return maxCount;
}