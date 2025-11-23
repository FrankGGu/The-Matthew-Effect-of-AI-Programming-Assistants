int maxDistance(int** points, int pointsSize, int* pointsColSize) {
    int maxDist = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < pointsSize; j++) {
            if (i != j) {
                int dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
        }
    }
    return maxDist;
}