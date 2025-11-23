#include <stdlib.h> // For abs

int minTimeToVisitAllPoints(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize <= 1) {
        return 0;
    }

    int totalTime = 0;
    for (int i = 0; i < pointsSize - 1; i++) {
        int x1 = points[i][0];
        int y1 = points[i][1];
        int x2 = points[i+1][0];
        int y2 = points[i+1][1];

        int dx = abs(x2 - x1);
        int dy = abs(y2 - y1);

        totalTime += (dx > dy ? dx : dy);
    }

    return totalTime;
}