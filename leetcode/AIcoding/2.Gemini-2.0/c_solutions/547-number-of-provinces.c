#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void dfs(int node, int** isConnected, int n, bool* visited) {
    visited[node] = true;
    for (int i = 0; i < n; i++) {
        if (isConnected[node][i] == 1 && !visited[i]) {
            dfs(i, isConnected, n, visited);
        }
    }
}

int findCircleNum(int** isConnected, int n, int* isConnectedColSize) {
    int provinces = 0;
    bool visited[n];
    for (int i = 0; i < n; i++) {
        visited[i] = false;
    }

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i, isConnected, n, visited);
            provinces++;
        }
    }

    return provinces;
}