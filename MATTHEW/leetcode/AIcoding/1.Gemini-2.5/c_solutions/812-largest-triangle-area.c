double largestTriangleArea(int** points, int pointsSize, int* pointsColSize) {
    double maxArea = 0.0;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            for (int k = j + 1; k < pointsSize; k++) {
                int x1 = points[i][0];
                int y1 = points[i][1];
                int x2 = points[j][0];
                int y2 = points[j][1];
                int x3 = points[k][0];
                int y3 = points[k][1];

                double currentArea = 0.5 * fabs((double)x1 * (y2 - y3) + (double)x2 * (y3 - y1) + (double)x3 * (y1 - y2));
                if (currentArea > maxArea) {
                    maxArea = currentArea;
                }
            }
        }
    }

    return maxArea;
}