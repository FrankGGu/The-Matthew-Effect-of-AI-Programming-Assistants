int max(int a, int b) {
    return a > b ? a : b;
}

int maxValueSum(int** board, int boardSize, int* boardColSize) {
    int n = boardSize;
    int m = boardColSize[0];

    // Precompute prefix and suffix maximums for rows
    int** left = (int**)malloc(n * sizeof(int*));
    int** right = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        left[i] = (int*)malloc(m * sizeof(int));
        right[i] = (int*)malloc(m * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        left[i][0] = board[i][0];
        for (int j = 1; j < m; j++) {
            left[i][j] = max(left[i][j-1], board[i][j]);
        }

        right[i][m-1] = board[i][m-1];
        for (int j = m-2; j >= 0; j--) {
            right[i][j] = max(right[i][j+1], board[i][j]);
        }
    }

    int ans = -2147483648;

    // Try all possible middle column for the second rook
    for (int j = 1; j < m-1; j++) {
        // Find best top-left and bottom-right combinations
        int bestTopLeft = -2147483648;
        for (int i1 = 0; i1 < n-2; i1++) {
            for (int i2 = i1+1; i2 < n-1; i2++) {
                int val1 = left[i1][j-1] + board[i2][j];
                bestTopLeft = max(bestTopLeft, val1);
            }
        }

        int bestBottomRight = -2147483648;
        for (int i2 = 1; i2 < n-1; i2++) {
            for (int i3 = i2+1; i3 < n; i3++) {
                int val2 = board[i2][j] + right[i3][j+1];
                bestBottomRight = max(bestBottomRight, val2);
            }
        }

        if (bestTopLeft != -2147483648 && bestBottomRight != -2147483648) {
            ans = max(ans, bestTopLeft + bestBottomRight - board[i2][j]);
        }
    }

    // Alternative approach: fix three rows and find best columns
    for (int i1 = 0; i1 < n; i1++) {
        for (int i2 = i1+1; i2 < n; i2++) {
            for (int i3 = i2+1; i3 < n; i3++) {
                // Find best three different columns
                int best = -2147483648;

                // Try all permutations of three different columns
                for (int j1 = 0; j1 < m; j1++) {
                    for (int j2 = 0; j2 < m; j2++) {
                        if (j2 == j1) continue;
                        for (int j3 = 0; j3 < m; j3++) {
                            if (j3 == j1 || j3 == j2) continue;
                            int sum = board[i1][j1] + board[i2][j2] + board[i3][j3];
                            best = max(best, sum);
                        }
                    }
                }

                ans = max(ans, best);
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(left[i]);
        free(right[i]);
    }
    free(left);
    free(right);

    return ans;
}