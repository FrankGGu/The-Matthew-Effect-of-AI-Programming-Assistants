int separateSquares(char** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = gridColSize[0];

    int* top = (int*)malloc(m * sizeof(int));
    int* bottom = (int*)malloc(m * sizeof(int));
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < m; i++) {
        top[i] = n;
        bottom[i] = -1;
    }
    for (int i = 0; i < n; i++) {
        left[i] = m;
        right[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == '1') {
                if (i < top[j]) top[j] = i;
                if (i > bottom[j]) bottom[j] = i;
                if (j < left[i]) left[i] = j;
                if (j > right[i]) right[i] = j;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == '1') {
                if (left[i] != j || right[i] != j || top[j] != i || bottom[j] != i) {
                    return 0;
                }
            }
        }
    }

    free(top);
    free(bottom);
    free(left);
    free(right);

    return 1;
}