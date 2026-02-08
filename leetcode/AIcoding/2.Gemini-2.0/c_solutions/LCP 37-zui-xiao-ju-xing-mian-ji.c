#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 4) return 0;

    int minArea = INT_MAX;
    int i, j, k, l;

    for (i = 0; i < pointsSize; i++) {
        for (j = i + 1; j < pointsSize; j++) {
            if (points[i][0] == points[j][0] || points[i][1] == points[j][1]) continue;

            int x1 = points[i][0];
            int y1 = points[i][1];
            int x2 = points[j][0];
            int y2 = points[j][1];

            int found3 = 0;
            int found4 = 0;

            for (k = 0; k < pointsSize; k++) {
                if (k == i || k == j) continue;

                if (points[k][0] == x1 && points[k][1] == y2) {
                    found3 = 1;
                }
                if (points[k][0] == x2 && points[k][1] == y1) {
                    found4 = 1;
                }
            }

            if (found3 && found4) {
                int area = abs(x1 - x2) * abs(y1 - y2);
                if (area < minArea) {
                    minArea = area;
                }
            }
        }
    }

    return (minArea == INT_MAX) ? 0 : minArea;
}