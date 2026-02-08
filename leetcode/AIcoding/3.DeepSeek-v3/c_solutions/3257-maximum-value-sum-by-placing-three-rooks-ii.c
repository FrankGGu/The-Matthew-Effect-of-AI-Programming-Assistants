long long maximumValueSum(int** board, int boardSize, int* boardColSize) {
    int m = boardSize;
    int n = boardColSize[0];

    long long leftMax[m][n];
    long long rightMax[m][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            leftMax[i][j] = -1e18;
            rightMax[i][j] = -1e18;
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (i == 0) {
                leftMax[i][j] = board[i][j];
            } else {
                leftMax[i][j] = (j > 0) ? fmax(leftMax[i-1][j-1], fmax(leftMax[i-1][j], (j < n-1) ? leftMax[i-1][j+1] : -1e18)) : fmax(leftMax[i-1][j], (j < n-1) ? leftMax[i-1][j+1] : -1e18);
                leftMax[i][j] += board[i][j];
            }
        }
    }

    for (int i = m-1; i >= 0; i--) {
        for (int j = 0; j < n; j++) {
            if (i == m-1) {
                rightMax[i][j] = board[i][j];
            } else {
                rightMax[i][j] = (j > 0) ? fmax(rightMax[i+1][j-1], fmax(rightMax[i+1][j], (j < n-1) ? rightMax[i+1][j+1] : -1e18)) : fmax(rightMax[i+1][j], (j < n-1) ? rightMax[i+1][j+1] : -1e18);
                rightMax[i][j] += board[i][j];
            }
        }
    }

    long long res = -1e18;
    for (int i = 1; i < m-1; i++) {
        for (int j = 1; j < n-1; j++) {
            long long left = fmax(leftMax[i-1][j-1], fmax(leftMax[i-1][j], leftMax[i-1][j+1]));
            long long right = fmax(rightMax[i+1][j-1], fmax(rightMax[i+1][j], rightMax[i+1][j+1]));
            res = fmax(res, left + board[i][j] + right);
        }
    }

    return res;
}