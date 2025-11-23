int numberOfBoomerangs(int** points, int pointsSize, int* pointsColSize) {
    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        int map[10000] = {0};
        for (int j = 0; j < pointsSize; j++) {
            if (i != j) {
                int dx = points[i][0] - points[j][0];
                int dy = points[i][1] - points[j][1];
                int dist = dx * dx + dy * dy;
                map[dist]++;
            }
        }
        for (int k = 0; k < 10000; k++) {
            if (map[k] > 0) {
                count += map[k] * (map[k] - 1);
            }
        }
    }
    return count;
}