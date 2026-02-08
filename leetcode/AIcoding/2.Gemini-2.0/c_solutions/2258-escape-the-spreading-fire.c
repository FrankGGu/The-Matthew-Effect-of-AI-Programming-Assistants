#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 300

int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};

bool isValid(int x, int y, int m, int n) {
    return x >= 0 && x < m && y >= 0 && y < n;
}

bool canEscape(int** grid, int m, int n, int time) {
    int fireGrid[MAX_SIZE][MAX_SIZE];
    int personGrid[MAX_SIZE][MAX_SIZE];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            fireGrid[i][j] = -1;
            personGrid[i][j] = -1;
        }
    }

    int fireQueue[m * n][2];
    int fireHead = 0, fireTail = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                fireQueue[fireTail][0] = i;
                fireQueue[fireTail][1] = j;
                fireTail++;
                fireGrid[i][j] = 0;
            }
        }
    }

    while (fireHead < fireTail) {
        int x = fireQueue[fireHead][0];
        int y = fireQueue[fireHead][1];
        fireHead++;

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (isValid(nx, ny, m, n) && fireGrid[nx][ny] == -1) {
                fireGrid[nx][ny] = fireGrid[x][y] + 1;
                fireQueue[fireTail][0] = nx;
                fireQueue[fireTail][1] = ny;
                fireTail++;
            }
        }
    }

    int personQueue[m * n][2];
    int personHead = 0, personTail = 0;

    personQueue[personTail][0] = 0;
    personQueue[personTail][1] = 0;
    personTail++;
    personGrid[0][0] = time;

    while (personHead < personTail) {
        int x = personQueue[personHead][0];
        int y = personQueue[personHead][1];
        personHead++;

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (isValid(nx, ny, m, n) && grid[nx][ny] != 2 && personGrid[nx][ny] == -1) {
                int arriveTime = personGrid[x][y] + 1;

                if (fireGrid[nx][ny] == -1 || arriveTime < fireGrid[nx][ny]) {
                    personGrid[nx][ny] = arriveTime;
                    personQueue[personTail][0] = nx;
                    personQueue[personTail][1] = ny;
                    personTail++;
                }
            }
        }
    }

    return personGrid[m - 1][n - 1] != -1;
}

int maximumMinutes(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int left = 0, right = m * n;
    int ans = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canEscape(grid, m, n, mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    if (ans == m * n) {
        return 1000000000;
    }

    return ans;
}