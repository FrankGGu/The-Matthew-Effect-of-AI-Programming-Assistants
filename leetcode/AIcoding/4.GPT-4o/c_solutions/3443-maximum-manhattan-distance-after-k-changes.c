int maxManhattanDistance(int** points, int pointsSize, int* pointsColSize, int k) {
    int maxDistance = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < pointsSize; j++) {
            if (i != j) {
                int dx = abs(points[i][0] - points[j][0]);
                int dy = abs(points[i][1] - points[j][1]);
                int distance = dx + dy;
                maxDistance = fmax(maxDistance, distance);
            }
        }
    }
    return maxDistance + k;
}