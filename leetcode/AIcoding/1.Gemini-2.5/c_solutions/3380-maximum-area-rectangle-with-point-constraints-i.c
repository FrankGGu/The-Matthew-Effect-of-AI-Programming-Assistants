#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

int maximumAreaRectangleWithPointConstraints(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize == 0) {
        return 0;
    }

    int min_x = points[0][0];
    int max_x = points[0][0];
    int min_y = points[0][1];
    int max_y = points[0][1];

    for (int i = 1; i < pointsSize; i++) {
        min_x = MIN(min_x, points[i][0]);
        max_x = MAX(max_x, points[i][0]);
        min_y = MIN(min_y, points[i][1]);
        max_y = MAX(max_y, points[i][1]);
    }

    int width = max_x - min_x;
    int height = max_y - min_y;

    return width * height;
}