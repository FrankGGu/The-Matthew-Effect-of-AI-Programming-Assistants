int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 3) return pointsSize;

    int max_points = 0;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            int count = 2;
            for (int k = 0; k < pointsSize; k++) {
                if (k != i && k != j) {
                    if ((points[j][1] - points[i][1]) * (points[k][0] - points[i][0]) == 
                        (points[k][1] - points[i][1]) * (points[j][0] - points[i][0])) {
                        count++;
                    }
                }
            }
            if (count > max_points) {
                max_points = count;
            }
        }
    }

    return max_points;
}