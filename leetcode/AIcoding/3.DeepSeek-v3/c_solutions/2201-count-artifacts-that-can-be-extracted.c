int digArtifacts(int n, int** artifacts, int artifactsSize, int* artifactsColSize, int** dig, int digSize, int* digColSize) {
    int grid[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            grid[i][j] = 0;
        }
    }

    for (int i = 0; i < digSize; i++) {
        grid[dig[i][0]][dig[i][1]] = 1;
    }

    int count = 0;
    for (int i = 0; i < artifactsSize; i++) {
        int r1 = artifacts[i][0];
        int c1 = artifacts[i][1];
        int r2 = artifacts[i][2];
        int c2 = artifacts[i][3];

        int canExtract = 1;
        for (int r = r1; r <= r2; r++) {
            for (int c = c1; c <= c2; c++) {
                if (grid[r][c] == 0) {
                    canExtract = 0;
                    break;
                }
            }
            if (!canExtract) break;
        }

        if (canExtract) {
            count++;
        }
    }

    return count;
}