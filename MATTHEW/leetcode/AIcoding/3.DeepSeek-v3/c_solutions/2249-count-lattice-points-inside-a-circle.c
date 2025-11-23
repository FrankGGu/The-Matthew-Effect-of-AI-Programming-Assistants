int countLatticePoints(int** circles, int circlesSize, int* circlesColSize) {
    int count = 0;
    int minX = 201, maxX = -1, minY = 201, maxY = -1;

    for (int i = 0; i < circlesSize; i++) {
        int x = circles[i][0];
        int y = circles[i][1];
        int r = circles[i][2];
        if (x - r < minX) minX = x - r;
        if (x + r > maxX) maxX = x + r;
        if (y - r < minY) minY = y - r;
        if (y + r > maxY) maxY = y + r;
    }

    for (int i = minX; i <= maxX; i++) {
        for (int j = minY; j <= maxY; j++) {
            for (int k = 0; k < circlesSize; k++) {
                int dx = i - circles[k][0];
                int dy = j - circles[k][1];
                int r = circles[k][2];
                if (dx * dx + dy * dy <= r * r) {
                    count++;
                    break;
                }
            }
        }
    }

    return count;
}