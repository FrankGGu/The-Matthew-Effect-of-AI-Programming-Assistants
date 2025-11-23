#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dx[] = {0, 0, 1, -1, 1, 1, -1, -1};
int dy[] = {1, -1, 0, 0, 1, -1, 1, -1};

int n;
int row[4], col[4];
int dir[4];
int dist[4];
bool visited[4];
int ans;

bool check(int i, int d) {
    int x = row[i] + dist[i] * dx[d];
    int y = col[i] + dist[i] * dy[d];
    return x >= 0 && x < n && y >= 0 && y < n;
}

bool collide(int i, int j) {
    if (dir[i] != dir[j]) return false;
    if (dist[i] == dist[j]) return true;
    int x1 = row[i] + dist[i] * dx[dir[i]];
    int y1 = col[i] + dist[i] * dy[dir[i]];
    int x2 = row[j] + dist[j] * dx[dir[j]];
    int y2 = col[j] + dist[j] * dy[dir[j]];
    return x1 == x2 && y1 == y2;
}

bool isValid() {
    for (int i = 0; i < n; i++) {
        if (!check(i, dir[i])) return false;
    }
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (collide(i, j)) return false;
        }
    }
    return true;
}

void solve(int k) {
    if (k == n) {
        if (isValid()) {
            ans++;
        }
        return;
    }

    for (int d = 0; d < 8; d++) {
        dir[k] = d;
        int maxDist = 0;
        if (d < 2) maxDist = n - 1;
        else if (d < 4) maxDist = n - 1;
        else maxDist = n - 1;

        for (int dis = 1; dis <= maxDist; dis++) {
            dist[k] = dis;
            solve(k + 1);
        }
        dist[k] = 0;
        solve(k + 1);
    }
}

int countCombinations(int boardSize, int* piecesPositions, int piecesPositionsSize) {
    n = boardSize;
    for (int i = 0; i < 4; i++) {
        visited[i] = false;
    }
    ans = 0;
    for (int i = 0; i < piecesPositionsSize / 2; i++) {
        row[i] = piecesPositions[2 * i] - 1;
        col[i] = piecesPositions[2 * i + 1] - 1;
    }

    solve(0);
    return ans;
}