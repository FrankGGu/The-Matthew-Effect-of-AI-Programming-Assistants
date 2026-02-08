#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 300

typedef struct {
    int x, y, t;
} Node;

int dirs[4][2] = {{1,0}, {-1,0}, {0,1}, {0,-1}};

int maximumMinutes(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int fireTime[MAX_SIZE][MAX_SIZE];
    memset(fireTime, -1, sizeof(fireTime));

    Node queue[MAX_SIZE * MAX_SIZE];
    int front = 0, rear = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                fireTime[i][j] = 0;
                queue[rear++] = (Node){i, j, 0};
            }
        }
    }

    while (front < rear) {
        Node cur = queue[front++];
        for (int d = 0; d < 4; d++) {
            int nx = cur.x + dirs[d][0];
            int ny = cur.y + dirs[d][1];
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 && fireTime[nx][ny] == -1) {
                fireTime[nx][ny] = cur.t + 1;
                queue[rear++] = (Node){nx, ny, cur.t + 1};
            }
        }
    }

    int left = 0, right = m * n;
    int ans = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int visited[MAX_SIZE][MAX_SIZE];
        memset(visited, 0, sizeof(visited));

        front = 0, rear = 0;
        if (grid[0][0] == 0 && (fireTime[0][0] == -1 || fireTime[0][0] > mid)) {
            queue[rear++] = (Node){0, 0, mid};
            visited[0][0] = 1;
        }

        int reached = 0;
        while (front < rear) {
            Node cur = queue[front++];
            if (cur.x == m - 1 && cur.y == n - 1) {
                reached = 1;
                break;
            }
            for (int d = 0; d < 4; d++) {
                int nx = cur.x + dirs[d][0];
                int ny = cur.y + dirs[d][1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 && !visited[nx][ny]) {
                    int nextTime = cur.t + 1;
                    if (fireTime[nx][ny] == -1 || (nextTime < fireTime[nx][ny]) || 
                        (nextTime == fireTime[nx][ny] && nx == m-1 && ny == n-1)) {
                        visited[nx][ny] = 1;
                        queue[rear++] = (Node){nx, ny, nextTime};
                    }
                }
            }
        }

        if (reached) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}