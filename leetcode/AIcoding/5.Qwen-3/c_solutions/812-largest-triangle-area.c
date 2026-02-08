#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double largestTriangleArea(int** points, int pointsSize, int* pointsColSize) {
    double maxArea = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            for (int k = j + 1; k < pointsSize; k++) {
                int x1 = points[i][0], y1 = points[i][1];
                int x2 = points[j][0], y2 = points[j][1];
                int x3 = points[k][0], y3 = points[k][1];
                double area = 0.5 * fabs((x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1));
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }
    return maxArea;
}