int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    int maxPoints = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < pointsColSize[i]; j++) {
            maxPoints = fmax(maxPoints, points[i][j]);
        }
    }
    return maxPoints;
}