int[] countRectangles(int[][] rectangles, int[][] points) {
    int n = sizeof(rectangles) / sizeof(rectangles[0]);
    int m = sizeof(points) / sizeof(points[0]);
    int* result = (int*)malloc(m * sizeof(int));

    int* count = (int*)calloc(101, sizeof(int));

    for (int i = 0; i < n; i++) {
        count[rectangles[i][1]]++;
    }

    for (int i = 1; i <= 100; i++) {
        count[i] += count[i - 1];
    }

    for (int i = 0; i < m; i++) {
        result[i] = count[100] - count[points[i][1] - 1];
    }

    return result;
}