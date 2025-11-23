typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int x;
    int y;
    int idx;
} PointWithIdx;

int cmp_x(const void* a, const void* b) {
    PointWithIdx* p1 = (PointWithIdx*)a;
    PointWithIdx* p2 = (PointWithIdx*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int cmp_y(const void* a, const void* b) {
    PointWithIdx* p1 = (PointWithIdx*)a;
    PointWithIdx* p2 = (PointWithIdx*)b;
    if (p1->y != p2->y) return p1->y - p2->y;
    return p1->x - p2->x;
}

int binarySearch(PointWithIdx* points, int n, int x, int y) {
    int left = 0, right = n - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (points[mid].x == x && points[mid].y == y) return 1;
        if (points[mid].x < x || (points[mid].x == x && points[mid].y < y)) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return 0;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int rectangleArea(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 4) return 0;

    PointWithIdx* pts = (PointWithIdx*)malloc(pointsSize * sizeof(PointWithIdx));
    for (int i = 0; i < pointsSize; i++) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
        pts[i].idx = i;
    }

    qsort(pts, pointsSize, sizeof(PointWithIdx), cmp_x);

    int maxArea = 0;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (pts[i].x == pts[j].x) continue;

            int x1 = pts[i].x, y1 = pts[i].y;
            int x2 = pts[j].x, y2 = pts[j].y;

            if (y1 == y2) continue;

            int bottomY = min(y1, y2);
            int topY = max(y1, y2);

            int foundBottom = 0, foundTop = 0;

            for (int k = 0; k < pointsSize; k++) {
                if (k == i || k == j) continue;

                if (pts[k].x == x1 && pts[k].y == bottomY) {
                    foundBottom = 1;
                }
                if (pts[k].x == x2 && pts[k].y == topY) {
                    foundTop = 1;
                }
            }

            if (foundBottom && foundTop) {
                int area = (x2 - x1) * (topY - bottomY);
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }

    free(pts);
    return maxArea;
}