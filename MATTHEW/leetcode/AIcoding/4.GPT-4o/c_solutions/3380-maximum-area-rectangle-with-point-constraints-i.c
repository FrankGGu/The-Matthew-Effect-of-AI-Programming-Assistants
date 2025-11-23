int maxAreaRect(int** points, int pointsSize, int* pointsColSize) {
    int maxArea = 0;
    int i, j, k, l;
    for (i = 0; i < pointsSize; i++) {
        for (j = i + 1; j < pointsSize; j++) {
            if (points[i][0] != points[j][0] && points[i][1] != points[j][1]) {
                for (k = 0; k < pointsSize; k++) {
                    for (l = 0; l < pointsSize; l++) {
                        if (points[k][0] == points[i][0] && points[l][0] == points[j][0] &&
                            points[k][1] == points[j][1] && points[l][1] == points[i][1]) {
                            int area = abs(points[i][0] - points[j][0]) * abs(points[i][1] - points[k][1]);
                            maxArea = maxArea > area ? maxArea : area;
                        }
                    }
                }
            }
        }
    }
    return maxArea;
}