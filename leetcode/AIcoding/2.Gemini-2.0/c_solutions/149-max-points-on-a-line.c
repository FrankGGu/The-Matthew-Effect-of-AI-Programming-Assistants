#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Point {
    int x;
    int y;
};

int maxPoints(struct Point* points, int pointsSize) {
    if (pointsSize <= 2) {
        return pointsSize;
    }

    int max_count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            int count = 2;
            for (int k = j + 1; k < pointsSize; k++) {
                if ((long long)(points[j].y - points[i].y) * (points[k].x - points[i].x) ==
                    (long long)(points[k].y - points[i].y) * (points[j].x - points[i].x)) {
                    count++;
                }
            }
            if (count > max_count) {
                max_count = count;
            }
        }
    }

    int same_point_max = 1;
    for (int i = 0; i < pointsSize; i++) {
        int same_count = 1;
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i].x == points[j].x && points[i].y == points[j].y) {
                same_count++;
            }
        }
        if (same_count > same_point_max) {
            same_point_max = same_count;
        }
    }

    if (max_count == 0)
    {
        return same_point_max;
    }
    return max_count;
}