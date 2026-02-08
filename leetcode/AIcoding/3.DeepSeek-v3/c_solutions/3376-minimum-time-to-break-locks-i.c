int minTimeToBreakLocks(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    int** visited = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        visited[i] = (int*)malloc(n * sizeof(int));
        memset(visited[i], 0, n * sizeof(int));
    }

    int directions[4][2] = {{0,1}, {1,0}, {0,-1}, {-1,0}};

    int start_i = -1, start_j = -1;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 'S') {
                start_i = i;
                start_j = j;
                break;
            }
        }
        if (start_i != -1) break;
    }

    dist[start_i][start_j] = 0;

    while (1) {
        int cur_i = -1, cur_j = -1;
        int min_dist = INT_MAX;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (!visited[i][j] && dist[i][j] < min_dist) {
                    min_dist = dist[i][j];
                    cur_i = i;
                    cur_j = j;
                }
            }
        }

        if (cur_i == -1) break;

        visited[cur_i][cur_j] = 1;

        if (grid[cur_i][cur_j] == 'T') {
            for (int i = 0; i < m; i++) {
                free(dist[i]);
                free(visited[i]);
            }
            free(dist);
            free(visited);
            return min_dist;
        }

        for (int d = 0; d < 4; d++) {
            int ni = cur_i + directions[d][0];
            int nj = cur_j + directions[d][1];

            if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                int cost;
                if (grid[ni][nj] == '.') {
                    cost = 1;
                } else if (grid[ni][nj] >= '1' && grid[ni][nj] <= '9') {
                    cost = grid[ni][nj] - '0';
                } else {
                    cost = 1;
                }

                if (dist[cur_i][cur_j] + cost < dist[ni][nj]) {
                    dist[ni][nj] = dist[cur_i][cur_j] + cost;
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(dist[i]);
        free(visited[i]);
    }
    free(dist);
    free(visited);

    return -1;
}