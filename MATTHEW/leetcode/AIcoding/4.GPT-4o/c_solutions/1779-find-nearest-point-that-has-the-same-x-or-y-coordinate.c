int nearestValidPoint(int x, int y, int** points, int pointsSize, int* pointsColSize) {
    int minDistance = INT_MAX;
    int index = -1;

    for (int i = 0; i < pointsSize; i++) {
        if (points[i][0] == x || points[i][1] == y) {
            int distance = abs(points[i][0] - x) + abs(points[i][1] - y);
            if (distance < minDistance) {
                minDistance = distance;
                index = i;
            }
        }
    }

    return index;
}