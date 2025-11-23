#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAreaRectangles(int** points, int pointsSize, int* pointsColSize, int k) {
    int min_rects = INT_MAX;

    for (int i = 0; i < (1 << pointsSize); i++) {
        if (__builtin_popcount(i) >= k) {
            int x_min = INT_MAX, x_max = INT_MIN, y_min = INT_MAX, y_max = INT_MIN;
            int count = 0;

            for (int j = 0; j < pointsSize; j++) {
                if ((i >> j) & 1) {
                    x_min = (x_min < points[j][0]) ? x_min : points[j][0];
                    x_max = (x_max > points[j][0]) ? x_max : points[j][0];
                    y_min = (y_min < points[j][1]) ? y_min : points[j][1];
                    y_max = (y_max > points[j][1]) ? y_max : points[j][1];
                    count++;
                }
            }

            if (count >= k) {
                int area = (x_max - x_min) * (y_max - y_min);
                min_rects = (min_rects < area) ? min_rects : area;
            }
        }
    }

    return (min_rects == INT_MAX) ? -1 : min_rects;
}