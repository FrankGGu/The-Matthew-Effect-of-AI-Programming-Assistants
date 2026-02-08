#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int checkWays(int** pairs, int pairsSize, int* pairsColSize, int n) {
    int adj[n + 1][n + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            adj[i][j] = 0;
        }
    }
    int degree[n + 1];
    for (int i = 0; i <= n; i++) {
        degree[i] = 0;
    }

    for (int i = 0; i < pairsSize; i++) {
        int u = pairs[i][0];
        int v = pairs[i][1];
        adj[u][v] = 1;
        adj[v][u] = 1;
        degree[u]++;
        degree[v]++;
    }

    int root = -1;
    for (int i = 1; i <= n; i++) {
        if (degree[i] == n - 1) {
            root = i;
            break;
        }
    }

    if (root == -1) return 0;

    int count = 0;
    for (int i = 1; i <= n; i++) {
        if (degree[i] == n - 1) count++;
    }

    int ans = 1;
    if (count > 1) ans = 2;

    for (int i = 1; i <= n; i++) {
        if (i == root) continue;
        int parent = -1;
        int parentDegree = n;
        for (int j = 1; j <= n; j++) {
            if (i == j) continue;
            if (adj[i][j] == 1) {
                if (degree[j] < parentDegree) {
                    parentDegree = degree[j];
                    parent = j;
                }
            }
        }

        if (parent == -1) return 0;

        for (int j = 1; j <= n; j++) {
            if (i == j || j == parent) continue;
            if (adj[i][j] == 1 && adj[parent][j] == 0) {
                return 0;
            }
        }

        if (degree[parent] == degree[i]) ans = 2;
    }

    return ans;
}