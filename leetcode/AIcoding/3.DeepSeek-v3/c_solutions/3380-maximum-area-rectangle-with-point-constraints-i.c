typedef struct {
    int x;
    int y;
} Point;

int cmp(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) {
        return p1->x - p2->x;
    }
    return p1->y - p2->y;
}

int maxRectangleArea(int** points, int pointsSize, int* pointsColSize) {
    Point* pts = (Point*)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }

    qsort(pts, pointsSize, sizeof(Point), cmp);

    int maxArea = 0;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (pts[i].x == pts[j].x) continue;
            if (pts[i].y == pts[j].y) continue;

            Point p3 = {pts[i].x, pts[j].y};
            Point p4 = {pts[j].x, pts[i].y};

            int found3 = 0, found4 = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (pts[k].x == p3.x && pts[k].y == p3.y) {
                    found3 = 1;
                }
                if (pts[k].x == p4.x && pts[k].y == p4.y) {
                    found4 = 1;
                }
            }

            if (found3 && found4) {
                int area = abs(pts[j].x - pts[i].x) * abs(pts[j].y - pts[i].y);
                if (area > maxArea) {
                    maxArea = area;
                }
            }
        }
    }

    free(pts);
    return maxArea;
}