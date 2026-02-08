int numberOfWays(int** points, int pointsSize, int* pointsColSize) {
    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < pointsSize; j++) {
            if (i == j) {
                continue;
            }

            if (points[i][0] >= points[j][0] && points[i][1] >= points[j][1]) {
                count++;
            }
        }
    }
    return count;
}