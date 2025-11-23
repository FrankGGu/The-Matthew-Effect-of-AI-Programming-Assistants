typedef struct {
    int x;
    int y;
} Point;

int minAreaRect(Point* points, int pointsSize) {
    int minArea = INT_MAX;
    int seen[10000][10000] = {0};

    for (int i = 0; i < pointsSize; i++) {
        seen[points[i].x][points[i].y] = 1;
    }

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            if (points[i].x != points[j].x && points[i].y != points[j].y) {
                if (seen[points[i].x][points[j].y] && seen[points[j].x][points[i].y]) {
                    int area = abs((points[i].x - points[j].x) * (points[i].y - points[j].y));
                    if (area > 0) {
                        minArea = fmin(minArea, area);
                    }
                }
            }
        }
    }

    return minArea == INT_MAX ? 0 : minArea;
}