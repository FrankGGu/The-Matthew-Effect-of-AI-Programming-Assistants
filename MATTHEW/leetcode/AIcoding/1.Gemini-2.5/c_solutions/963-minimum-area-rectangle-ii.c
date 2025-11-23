#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <float.h>

typedef struct Point {
    int x;
    int y;
} Point;

int comparePoints(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) {
        return p1->x - p2->x;
    }
    return p1->y - p2->y;
}

int pointExists(Point *points, int num_points, int target_x, int target_y) {
    Point target = {target_x, target_y};
    return bsearch(&target, points, num_points, sizeof(Point), comparePoints) != NULL;
}

double minAreaRect(int** points_raw, int points_rawSize, int* points_rawColSize) {
    if (points_rawSize < 4) {
        return 0.0;
    }

    Point points[points_rawSize];
    for (int i = 0; i < points_rawSize; ++i) {
        points[i].x = points_raw[i][0];
        points[i].y = points_raw[i][1];
    }

    qsort(points, points_rawSize, sizeof(Point), comparePoints);

    double min_area = DBL_MAX;

    for (int i = 0; i < points_rawSize; ++i) {
        Point p1 = points[i];
        for (int j = 0; j < points_rawSize; ++j) {
            if (i == j) continue;
            Point p2 = points[j];

            for (int k = 0; k < points_rawSize; ++k) {
                if (k == i || k == j) continue;
                Point p3 = points[k];

                long long dx12 = (long long)p2.x - p1.x;
                long long dy12 = (long long)p2.y - p1.y;
                long long dx13 = (long long)p3.x - p1.x;
                long long dy13 = (long long)p3.y - p1.y;

                if (dx12 * dx13 + dy12 * dy13 == 0) {
                    int p4_x = p2.x + p3.x - p1.x;
                    int p4_y = p2.y + p3.y - p1.y;

                    if (pointExists(points, points_rawSize, p4_x, p4_y)) {
                        long long len_sq_12 = dx12 * dx12 + dy12 * dy12;
                        long long len_sq_13 = dx13 * dx13 + dy13 * dy13;

                        // len_sq_12 and len_sq_13 cannot be 0 because points are unique and i!=j, k!=i,k!=j
                        // But for robustness, check anyway.
                        if (len_sq_12 == 0 || len_sq_13 == 0) {
                            continue;
                        }

                        double current_area = sqrt((double)len_sq_12) * sqrt((double)len_sq_13);
                        if (current_area < min_area) {
                            min_area = current_area;
                        }
                    }
                }
            }
        }
    }

    if (min_area == DBL_MAX) {
        return 0.0;
    }
    return min_area;
}