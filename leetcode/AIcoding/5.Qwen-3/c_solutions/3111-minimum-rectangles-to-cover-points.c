#include <stdio.h>
#include <stdlib.h>

int numberOfRectangles(int** points, int pointsSize, int* pointsColSize) {
    int x[1001] = {0};
    int y[1001] = {0};
    for (int i = 0; i < pointsSize; i++) {
        x[points[i][0]]++;
        y[points[i][1]]++;
    }
    int count = 0;
    for (int i = 0; i <= 1000; i++) {
        if (x[i] > 0) count++;
        if (y[i] > 0) count++;
    }
    return count;
}