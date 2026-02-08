int countPairs(int** points, int pointsSize, int* pointsColSize, int k) {
    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            int dx = points[i][0] - points[j][0];
            int dy = points[i][1] - points[j][1];
            if (dx * dx + dy * dy == k * k) {
                count++;
            }
        }
    }
    return count;
}