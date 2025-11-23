#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    double angle_a = *(double *)a;
    double angle_b = *(double *)b;
    if (angle_a < angle_b) return -1;
    if (angle_a > angle_b) return 1;
    return 0;
}

int maxVisiblePoints(int** points, int pointsSize, int* pointsColSize, int angle, int* location, int locationSize) {
    double angles[pointsSize * 2];
    int angleSize = 0;
    int same = 0;
    for (int i = 0; i < pointsSize; i++) {
        int dx = points[i][0] - location[0];
        int dy = points[i][1] - location[1];
        if (dx == 0 && dy == 0) {
            same++;
        } else {
            double angle_rad = atan2(dy, dx);
            if (angle_rad < 0) {
                angle_rad += 2 * M_PI;
            }
            angles[angleSize++] = angle_rad;
        }
    }
    qsort(angles, angleSize, sizeof(double), cmp);
    for (int i = 0; i < angleSize; i++) {
        angles[angleSize + i] = angles[i] + 2 * M_PI;
    }
    int totalSize = angleSize * 2;
    int left = 0, right = 0;
    int maxPoints = 0;
    while (right < totalSize && left < angleSize) {
        double diff = angles[right] - angles[left];
        if (diff <= angle * M_PI / 180.0) {
            right++;
        } else {
            left++;
        }
        int pointsInView = right - left;
        if (pointsInView > maxPoints) {
            maxPoints = pointsInView;
        }
    }
    return maxPoints + same;
}