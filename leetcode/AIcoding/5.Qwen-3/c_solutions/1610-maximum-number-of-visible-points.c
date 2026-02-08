#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    double x;
    double y;
} Point;

double angle(Point p) {
    return atan2(p.y, p.x);
}

int compare(const void *a, const void *b) {
    return (*(double*)a - *(double*)b) > 0 ? 1 : -1;
}

int visiblePoints(int** points, int pointsSize, int* pointsColSize, int radius, int angle) {
    int n = pointsSize;
    Point origin = {0, 0};
    double angles[n];
    int count = 0;

    for (int i = 0; i < n; i++) {
        int x = points[i][0];
        int y = points[i][1];
        if (x == 0 && y == 0) {
            count++;
            continue;
        }
        angles[count++] = atan2(y, x);
    }

    qsort(angles, count, sizeof(double), compare);

    for (int i = 0; i < count; i++) {
        angles[count + i] = angles[i] + 2 * M_PI;
    }

    int maxVisible = 0;
    double limit = angle * M_PI / 180;
    int j = 0;

    for (int i = 0; i < count; i++) {
        while (j < count + i && angles[j] - angles[i] <= limit) {
            j++;
        }
        maxVisible = fmax(maxVisible, j - i);
    }

    return maxVisible + count;
}