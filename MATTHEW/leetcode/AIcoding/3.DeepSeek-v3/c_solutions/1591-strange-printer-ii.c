int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int isPrintable(int** targetGrid, int targetGridSize, int* targetGridColSize) {
    int color[61][4];
    int hasColor[61] = {0};
    int m = targetGridSize, n = targetGridColSize[0];

    for (int i = 0; i <= 60; i++) {
        color[i][0] = m;
        color[i][1] = n;
        color[i][2] = -1;
        color[i][3] = -1;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int c = targetGrid[i][j];
            hasColor[c] = 1;
            color[c][0] = min(color[c][0], i);
            color[c][1] = min(color[c][1], j);
            color[c][2] = max(color[c][2], i);
            color[c][3] = max(color[c][3], j);
        }
    }

    int changed = 1;
    while (changed) {
        changed = 0;
        for (int c = 1; c <= 60; c++) {
            if (!hasColor[c]) continue;
            int top = color[c][0], left = color[c][1], bottom = color[c][2], right = color[c][3];
            int valid = 1;
            for (int i = top; i <= bottom && valid; i++) {
                for (int j = left; j <= right && valid; j++) {
                    int cell = targetGrid[i][j];
                    if (cell != c && cell != 0) {
                        valid = 0;
                    }
                }
            }
            if (valid) {
                changed = 1;
                for (int i = top; i <= bottom; i++) {
                    for (int j = left; j <= right; j++) {
                        targetGrid[i][j] = 0;
                    }
                }
                hasColor[c] = 0;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (targetGrid[i][j] != 0) {
                return 0;
            }
        }
    }
    return 1;
}