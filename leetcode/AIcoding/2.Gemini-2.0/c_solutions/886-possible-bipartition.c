#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool possibleBipartition(int n, int** dislikes, int dislikesSize, int* dislikesColSize) {
    int color[n + 1];
    for (int i = 1; i <= n; i++) {
        color[i] = 0;
    }

    int adj[n + 1][n + 1];
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            adj[i][j] = 0;
        }
    }

    for (int i = 0; i < dislikesSize; i++) {
        adj[dislikes[i][0]][dislikes[i][1]] = 1;
        adj[dislikes[i][1]][dislikes[i][0]] = 1;
    }

    bool dfs(int node, int c) {
        color[node] = c;
        for (int i = 1; i <= n; i++) {
            if (adj[node][i] == 1) {
                if (color[i] == 0) {
                    if (!dfs(i, -c)) {
                        return false;
                    }
                } else if (color[i] == c) {
                    return false;
                }
            }
        }
        return true;
    }

    for (int i = 1; i <= n; i++) {
        if (color[i] == 0) {
            if (!dfs(i, 1)) {
                return false;
            }
        }
    }

    return true;
}