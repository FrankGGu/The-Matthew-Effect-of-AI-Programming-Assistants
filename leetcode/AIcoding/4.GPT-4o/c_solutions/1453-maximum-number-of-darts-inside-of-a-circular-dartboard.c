#define MAXN 100

typedef struct {
    int x, y;
} Point;

double distance(Point a, Point b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

int numPoints(Point* points, int pointsSize, double r) {
    int maxCount = 0;
    for (int i = 0; i < pointsSize; i++) {
        int count = 0;
        for (int j = 0; j < pointsSize; j++) {
            if (distance(points[i], points[j]) <= r) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
        }
    }
    return maxCount;
}

int numDarts(Point* points, int pointsSize, double r) {
    return numPoints(points, pointsSize, r);
}