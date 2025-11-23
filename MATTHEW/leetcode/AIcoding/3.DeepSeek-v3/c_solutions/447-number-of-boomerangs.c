int numberOfBoomerangs(int** points, int pointsSize, int* pointsColSize) {
    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        int dist[pointsSize];
        for (int j = 0; j < pointsSize; j++) {
            int dx = points[i][0] - points[j][0];
            int dy = points[i][1] - points[j][1];
            dist[j] = dx * dx + dy * dy;
        }
        for (int j = 0; j < pointsSize; j++) {
            if (j == i) continue;
            for (int k = j + 1; k < pointsSize; k++) {
                if (k == i) continue;
                if (dist[j] == dist[k]) {
                    count += 2;
                }
            }
        }
    }
    return count;
}