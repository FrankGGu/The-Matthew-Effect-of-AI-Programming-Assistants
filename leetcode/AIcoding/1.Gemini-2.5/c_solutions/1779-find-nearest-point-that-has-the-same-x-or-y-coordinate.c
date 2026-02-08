#include <stdlib.h> // For abs
#include <limits.h> // For INT_MAX

int nearestValidPoint(int x, int y, int** points, int pointsSize, int* pointsColSize) {
    int minDistance = INT_MAX;
    int minIndex = -1;

    for (int i = 0; i < pointsSize; i++) {
        int px = points[i][0];
        int py = points[i][1];

        if (px == x || py == y) {
            int currentDistance = abs(x - px) + abs(y - py);
            if (currentDistance < minDistance) {
                minDistance = currentDistance;
                minIndex = i;
            }
        }
    }

    return minIndex;
}