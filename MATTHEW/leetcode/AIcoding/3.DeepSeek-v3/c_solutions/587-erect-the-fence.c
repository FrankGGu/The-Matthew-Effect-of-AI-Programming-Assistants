/**
 * Definition for a point.
 * struct Point {
 *     int x;
 *     int y;
 * };
 */

int cross(const struct Point* o, const struct Point* a, const struct Point* b) {
    return (a->x - o->x) * (b->y - o->y) - (a->y - o->y) * (b->x - o->x);
}

int compare(const void* v1, const void* v2) {
    struct Point* p1 = (struct Point*)v1;
    struct Point* p2 = (struct Point*)v2;
    if (p1->x == p2->x) {
        return p1->y - p2->y;
    }
    return p1->x - p2->x;
}

struct Point* outerTrees(struct Point* points, int pointsSize, int* returnSize) {
    if (pointsSize <= 1) {
        *returnSize = pointsSize;
        return points;
    }

    qsort(points, pointsSize, sizeof(struct Point), compare);

    struct Point* hull = malloc(2 * pointsSize * sizeof(struct Point));
    int k = 0;

    for (int i = 0; i < pointsSize; i++) {
        while (k >= 2 && cross(&hull[k-2], &hull[k-1], &points[i]) < 0) k--;
        hull[k++] = points[i];
    }

    for (int i = pointsSize - 2, t = k + 1; i >= 0; i--) {
        while (k >= t && cross(&hull[k-2], &hull[k-1], &points[i]) < 0) k--;
        hull[k++] = points[i];
    }

    k--;
    *returnSize = k;

    int size = k;
    qsort(hull, size, sizeof(struct Point), compare);
    int m = 0;
    for (int i = 0; i < size; i++) {
        if (i > 0 && hull[i].x == hull[i-1].x && hull[i].y == hull[i-1].y) continue;
        hull[m++] = hull[i];
    }
    *returnSize = m;

    return hull;
}