#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x, y;
} Point;

int compare(const void *a, const void *b) {
    return ((Point *)a)->x - ((Point *)b)->x;
}

int maxArea(int** points, int pointsSize, int* pointsColSize) {
    qsort(points, pointsSize, sizeof(Point), compare);
    int max_area = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i][0] == points[j][0]) continue;
            int width = points[j][0] - points[i][0];
            int y1 = points[i][1], y2 = points[j][1];
            for (int k = 0; k < pointsSize; k++) {
                if (points[k][0] > points[j][0]) break;
                if (points[k][1] == y1 || points[k][1] == y2) {
                    for (int l = k + 1; l < pointsSize; l++) {
                        if (points[l][0] > points[j][0]) break;
                        if ((points[l][1] == y1 && points[k][1] == y2) || 
                            (points[l][1] == y2 && points[k][1] == y1)) {
                            int height = abs(y1 - y2);
                            max_area = fmax(max_area, width * height);
                        }
                    }
                }
            }
        }
    }
    return max_area;
}