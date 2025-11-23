#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

double distance(Point a, Point b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

double findMinAverageDistance(Point* points, int pointsSize) {
    double minAvg = INFINITY;
    for (int x = 0; x <= 1000; x++) {
        for (int y = 0; y <= 1000; y++) {
            double total = 0.0;
            for (int i = 0; i < pointsSize; i++) {
                total += distance((Point){x, y}, points[i]);
            }
            double avg = total / pointsSize;
            if (avg < minAvg) {
                minAvg = avg;
            }
        }
    }
    return minAvg;
}

double bestPosition(int** points, int pointsSize, int* pointsColSize) {
    return findMinAverageDistance((Point*)points, pointsSize);
}