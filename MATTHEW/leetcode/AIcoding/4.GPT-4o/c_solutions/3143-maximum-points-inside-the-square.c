int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize == 0) return 0;
    int maxCount = 1;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            int count = 0;
            int x1 = points[i][0], y1 = points[i][1];
            int x2 = points[j][0], y2 = points[j][1];
            int minX = fmin(x1, x2);
            int maxX = fmax(x1, x2);
            int minY = fmin(y1, y2);
            int maxY = fmax(y1, y2);

            for (int k = 0; k < pointsSize; k++) {
                int x = points[k][0], y = points[k][1];
                if (x >= minX && x <= maxX && y >= minY && y <= maxY) {
                    count++;
                }
            }

            maxCount = fmax(maxCount, count);
        }
    }

    return maxCount;
}