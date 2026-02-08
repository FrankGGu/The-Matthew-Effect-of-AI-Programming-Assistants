#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 4) return 0;

    int minArea = 0;
    bool found = false;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i][0] == points[j][0] || points[i][1] == points[j][1]) continue;

            int x1 = points[i][0];
            int y1 = points[i][1];
            int x2 = points[j][0];
            int y2 = points[j][1];

            bool found3 = false;
            bool found4 = false;

            for (int k = 0; k < pointsSize; k++) {
                if (k == i || k == j) continue;

                if (points[k][0] == x1 && points[k][1] == y2) {
                    found3 = true;
                }
                if (points[k][0] == x2 && points[k][1] == y1) {
                    found4 = true;
                }
            }

            if (found3 && found4) {
                int area = abs(x1 - x2) * abs(y1 - y2);
                if (!found) {
                    minArea = area;
                    found = true;
                } else {
                    if (area < minArea) {
                        minArea = area;
                    }
                }
            }
        }
    }

    return minArea;
}