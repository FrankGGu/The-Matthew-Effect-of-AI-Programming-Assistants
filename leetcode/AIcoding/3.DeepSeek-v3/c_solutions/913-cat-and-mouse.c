int catMouseGame(int** graph, int graphSize, int* graphColSize) {
    int n = graphSize;
    int dp[n][n][2];
    int outdegree[n][n][2];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            outdegree[i][j][0] = graph[i][graphColSize[i]];
            outdegree[i][j][1] = graph[j][graphColSize[j]];
            dp[i][j][0] = 0;
            dp[i][j][1] = 0;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int t = 0; t < 2; t++) {
            dp[0][i][t] = 1;
            dp[i][i][t] = 2;
        }
    }

    int queue[n * n * 2][3];
    int front = 0, rear = 0;

    for (int i = 0; i < n; i++) {
        for (int t = 0; t < 2; t++) {
            if (dp[0][i][t] != 0) {
                queue[rear][0] = 0;
                queue[rear][1] = i;
                queue[rear][2] = t;
                rear++;
            }
            if (dp[i][i][t] != 0) {
                queue[rear][0] = i;
                queue[rear][1] = i;
                queue[rear][2] = t;
                rear++;
            }
        }
    }

    while (front < rear) {
        int m = queue[front][0];
        int c = queue[front][1];
        int t = queue[front][2];
        int result = dp[m][c][t];
        front++;

        if (t == 0) {
            for (int prev : graph[c]) {
                if (prev == 0) continue;
                if (dp[m][prev][1] != 0) continue;
                if (result == 2) {
                    dp[m][prev][1] = 2;
                    queue[rear][0] = m;
                    queue[rear][1] = prev;
                    queue[rear][2] = 1;
                    rear++;
                } else {
                    outdegree[m][prev][1]--;
                    if (outdegree[m][prev][1] == 0) {
                        dp[m][prev][1] = 1;
                        queue[rear][0] = m;
                        queue[rear][1] = prev;
                        queue[rear][2] = 1;
                        rear++;
                    }
                }
            }
        } else {
            for (int prev : graph[m]) {
                if (dp[prev][c][0] != 0) continue;
                if (result == 1) {
                    dp[prev][c][0] = 1;
                    queue[rear][0] = prev;
                    queue[rear][1] = c;
                    queue[rear][2] = 0;
                    rear++;
                } else {
                    outdegree[prev][c][0]--;
                    if (outdegree[prev][c][0] == 0) {
                        dp[prev][c][0] = 2;
                        queue[rear][0] = prev;
                        queue[rear][1] = c;
                        queue[rear][2] = 0;
                        rear++;
                    }
                }
            }
        }
    }

    return dp[1][2][0];
}