#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

int cross_product(Point p, Point q, Point r) {
    return (q.x - p.x) * (r.y - q.y) - (q.y - p.y) * (r.x - q.x);
}

int compare(const void *a, const void *b) {
    Point p1 = *(Point *)a;
    Point p2 = *(Point *)b;
    if (p1.x != p2.x) {
        return p1.x - p2.x;
    } else {
        return p1.y - p2.y;
    }
}

Point* outerTrees(Point* points, int pointsSize, int* returnSize) {
    if (pointsSize <= 3) {
        *returnSize = pointsSize;
        return points;
    }

    qsort(points, pointsSize, sizeof(Point), compare);

    Point* hull = (Point*)malloc(2 * pointsSize * sizeof(Point));
    int k = 0;

    for (int i = 0; i < pointsSize; i++) {
        while (k >= 2 && cross_product(hull[k - 2], hull[k - 1], points[i]) < 0) {
            k--;
        }
        hull[k++] = points[i];
    }

    int t = k + 1;

    for (int i = pointsSize - 2, l = k; i >= 0; i--) {
        while (k >= t && cross_product(hull[k - 2], hull[k - 1], points[i]) < 0) {
            k--;
        }
        hull[k++] = points[i];
    }

    *returnSize = k - 1;

    Point* result = (Point*)malloc((*returnSize) * sizeof(Point));

    int* used = (int*)calloc(pointsSize, sizeof(int));
    int res_idx = 0;
    for(int i = 0; i < k - 1; i++)
    {
        int found = 0;
        for(int j = 0; j < pointsSize; j++)
        {
            if(points[j].x == hull[i].x && points[j].y == hull[i].y && used[j] == 0)
            {
                result[res_idx].x = points[j].x;
                result[res_idx].y = points[j].y;
                used[j] = 1;
                res_idx++;
                found = 1;
                break;
            }
        }
    }

    free(hull);
    free(used);

    return result;
}