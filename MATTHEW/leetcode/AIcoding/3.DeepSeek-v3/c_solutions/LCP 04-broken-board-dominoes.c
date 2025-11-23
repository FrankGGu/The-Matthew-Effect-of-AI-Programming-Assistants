int domino(int n, int m, int** broken, int brokenSize, int* brokenColSize) {
    int board[8][8] = {0};
    for (int i = 0; i < brokenSize; i++) {
        board[broken[i][0]][broken[i][1]] = 1;
    }

    int match[64];
    memset(match, -1, sizeof(match));

    int dirs[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};

    int visited[64];
    int timestamp = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if ((i + j) % 2 == 1 || board[i][j]) continue;

            timestamp++;
            int dfs(int x, int y) {
                int idx = x * m + y;
                if (visited[idx] == timestamp) return 0;
                visited[idx] = timestamp;

                for (int d = 0; d < 4; d++) {
                    int nx = x + dirs[d][0];
                    int ny = y + dirs[d][1];
                    if (nx >= 0 && nx < n && ny >= 0 && ny < m && !board[nx][ny]) {
                        int nidx = nx * m + ny;
                        if (match[nidx] == -1 || dfs(match[nidx] / m, match[nidx] % m)) {
                            match[nidx] = idx;
                            match[idx] = nidx;
                            return 1;
                        }
                    }
                }
                return 0;
            }
            dfs(i, j);
        }
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if ((i + j) % 2 == 0 && !board[i][j] && match[i * m + j] != -1) {
                count++;
            }
        }
    }
    return count;
}