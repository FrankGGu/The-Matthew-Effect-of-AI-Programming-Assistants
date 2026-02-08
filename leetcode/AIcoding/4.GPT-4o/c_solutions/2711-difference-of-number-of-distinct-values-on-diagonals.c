int[] differenceOfDistinctValues(int[][] grid) {
    int m = sizeof(grid) / sizeof(grid[0]);
    int n = sizeof(grid[0]) / sizeof(grid[0][0]);
    int* result = (int*)malloc(m * n * sizeof(int));

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int diag1[101] = {0}, diag2[101] = {0};
            for (int k = 0; k < m; k++) {
                if (k + j - i >= 0 && k + j - i < n) {
                    diag1[grid[k][k + j - i]]++;
                }
                if (k + i - j >= 0 && k + i - j < m) {
                    diag2[grid[k + i - j][k]]++;
                }
            }
            int count1 = 0, count2 = 0;
            for (int d = 0; d <= 100; d++) {
                if (diag1[d] > 0) count1++;
                if (diag2[d] > 0) count2++;
            }
            result[i * n + j] = count1 - count2;
        }
    }
    return result;
}