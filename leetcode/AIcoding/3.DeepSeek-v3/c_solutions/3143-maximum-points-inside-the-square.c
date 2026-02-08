typedef struct {
    char* tag;
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

int maxPointsInsideSquare(int** points, int pointsSize, int* pointsColSize, char* s) {
    Point* pts = (Point*)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        pts[i].tag = &s[i];
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }

    qsort(pts, pointsSize, sizeof(Point), cmp);

    int left = 0, right = 1e9;
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int seen[26] = {0};
        int valid = 1;
        int count = 0;

        for (int i = 0; i < pointsSize; i++) {
            if (abs(pts[i].x) <= mid && abs(pts[i].y) <= mid) {
                int idx = *(pts[i].tag) - 'a';
                if (seen[idx]) {
                    valid = 0;
                    break;
                }
                seen[idx] = 1;
                count++;
            }
        }

        if (valid) {
            ans = count;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    free(pts);
    return ans;
}