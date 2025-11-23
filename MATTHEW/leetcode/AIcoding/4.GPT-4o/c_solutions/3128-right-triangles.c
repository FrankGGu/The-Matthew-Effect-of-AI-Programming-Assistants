int countRightTriangles(int** points, int pointsSize, int* pointsColSize) {
    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            for (int k = j + 1; k < pointsSize; k++) {
                int a = (points[j][0] - points[i][0]) * (points[j][0] - points[i][0]) + 
                        (points[j][1] - points[i][1]) * (points[j][1] - points[i][1]);
                int b = (points[k][0] - points[j][0]) * (points[k][0] - points[j][0]) + 
                        (points[k][1] - points[j][1]) * (points[k][1] - points[j][1]);
                int c = (points[k][0] - points[i][0]) * (points[k][0] - points[i][0]) + 
                        (points[k][1] - points[i][1]) * (points[k][1] - points[i][1]);

                if (a + b == c || a + c == b || b + c == a) {
                    count++;
                }
            }
        }
    }
    return count;
}