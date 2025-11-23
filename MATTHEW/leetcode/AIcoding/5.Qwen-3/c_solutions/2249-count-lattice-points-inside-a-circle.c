#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int countLatticePoints(int** points, int pointsSize, int* pointsColSize, int radius) {
    int count = 0;
    for (int x = -radius; x <= radius; x++) {
        for (int y = -radius; y <= radius; y++) {
            int inside = 0;
            for (int i = 0; i < pointsSize; i++) {
                int dx = x - points[i][0];
                int dy = y - points[i][1];
                if (dx * dx + dy * dy <= radius * radius) {
                    inside = 1;
                    break;
                }
            }
            if (inside) count++;
        }
    }
    return count;
}