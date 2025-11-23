int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    int max_points = 0;
    for (int i = 0; i < pointsSize; i++) {
        int current_points = 0;
        for (int j = 0; j < pointsColSize[i]; j++) {
            current_points += points[i][j];
        }
        if (current_points > max_points) {
            max_points = current_points;
        }
    }
    return max_points;
}