#include <stdlib.h>
#include <string.h>

typedef struct {
    int x, y;
} Point;

int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

int minimalSteps(char** maze, int mazeSize) {
    int m = mazeSize, n = strlen(maze[0]);
    Point start, end;
    Point stones[16], buttons[16];
    int stone_cnt = 0, button_cnt = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (maze[i][j] == 'S') {
                start.x = i;
                start.y = j;
            } else if (maze[i][j] == 'T') {
                end.x = i;
                end.y = j;
            } else if (maze[i][j] == 'O') {
                stones[stone_cnt].x = i;
                stones[stone_cnt].y = j;
                stone_cnt++;
            } else if (maze[i][j] == 'M') {
                buttons[button_cnt].x = i;
                buttons[button_cnt].y = j;
                button_cnt++;
            }
        }
    }

    int** bfs(int sx, int sy) {
        int** dist = (int**)malloc(m * sizeof(int*));
        for (int i = 0; i < m; i++) {
            dist[i] = (int*)malloc(n * sizeof(int));
            memset(dist[i], -1, n * sizeof(int));
        }
        dist[sx][sy] = 0;
        Point* queue = (Point*)malloc(m * n * sizeof(Point));
        int front = 0, rear = 0;
        queue[rear++] = (Point){sx, sy};

        while (front < rear) {
            Point p = queue[front++];
            for (int k = 0; k < 4; k++) {
                int nx = p.x + dirs[k][0];
                int ny = p.y + dirs[k][1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] != '#' && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[p.x][p.y] + 1;
                    queue[rear++] = (Point){nx, ny};
                }
            }
        }
        free(queue);
        return dist;
    }

    int** start_dist = bfs(start.x, start.y);

    if (button_cnt == 0) {
        int res = start_dist[end.x][end.y];
        for (int i = 0; i < m; i++) free(start_dist[i]);
        free(start_dist);
        return res;
    }

    int** dists = (int**)malloc(button_cnt * sizeof(int*));
    for (int i = 0; i < button_cnt; i++) {
        dists[i] = (int*)malloc((button_cnt + 2) * sizeof(int));
        memset(dists[i], -1, (button_cnt + 2) * sizeof(int));
    }

    int*** button_dists = (int***)malloc(button_cnt * sizeof(int**));
    for (int i = 0; i < button_cnt; i++) {
        button_dists[i] = bfs(buttons[i].x, buttons[i].y);
    }

    for (int i = 0; i < button_cnt; i++) {
        int tmp = -1;
        for (int k = 0; k < stone_cnt; k++) {
            int sx = stones[k].x, sy = stones[k].y;
            if (button_dists[i][sx][sy] != -1 && start_dist[sx][sy] != -1) {
                int total = button_dists[i][sx][sy] + start_dist[sx][sy];
                if (tmp == -1 || total < tmp) {
                    tmp = total;
                }
            }
        }
        dists[i][button_cnt] = tmp;

        tmp = button_dists[i][end.x][end.y];
        dists[i][button_cnt + 1] = tmp;

        for (int j = i + 1; j < button_cnt; j++) {
            int mn = -1;
            for (int k = 0; k < stone_cnt; k++) {
                int sx = stones[k].x, sy = stones[k].y;
                if (button_dists[i][sx][sy] != -1 && button_dists[j][sx][sy] != -1) {
                    int total = button_dists[i][sx][sy] + button_dists[j][sx][sy];
                    if (mn == -1 || total < mn) {
                        mn = total;
                    }
                }
            }
            dists[i][j] = mn;
            dists[j][i] = mn;
        }
    }

    for (int i = 0; i < button_cnt; i++) {
        for (int j = 0; j < m; j++) free(button_dists[i][j]);
        free(button_dists[i]);
    }
    free(button_dists);

    for (int i = 0; i < m; i++) free(start_dist[i]);
    free(start_dist);

    int dp[1 << button_cnt][button_cnt];
    for (int i = 0; i < (1 << button_cnt); i++) {
        for (int j = 0; j < button_cnt; j++) {
            dp[i][j] = -1;
        }
    }

    for (int i = 0; i < button_cnt; i++) {
        if (dists[i][button_cnt] != -1) {
            dp[1 << i][i] = dists[i][button_cnt];
        }
    }

    for (int mask = 1; mask < (1 << button_cnt); mask++) {
        for (int i = 0; i < button_cnt; i++) {
            if ((mask & (1 << i)) == 0) continue;
            for (int j = 0; j < button_cnt; j++) {
                if ((mask & (1 << j)) || dists[i][j] == -1) continue;
                int new_mask = mask | (1 << j);
                int new_dist = dp[mask][i] + dists[i][j];
                if (dp[new_mask][j] == -1 || new_dist < dp[new_mask][j]) {
                    dp[new_mask][j] = new_dist;
                }
            }
        }
    }

    int res = -1;
    int full_mask = (1 << button_cnt) - 1;
    for (int i = 0; i < button_cnt; i++) {
        if (dp[full_mask][i] != -1 && dists[i][button_cnt + 1] != -1) {
            int total = dp[full_mask][i] + dists[i][button_cnt + 1];
            if (res == -1 || total < res) {
                res = total;
            }
        }
    }

    for (int i = 0; i < button_cnt; i++) free(dists[i]);
    free(dists);

    return res;
}