#include <stdbool.h>
#include <stdlib.h>

void dfs(int city, int** isConnected, int n, bool* visited) {
    visited[city] = true;
    for (int neighbor = 0; neighbor < n; neighbor++) {
        if (isConnected[city][neighbor] == 1 && !visited[neighbor]) {
            dfs(neighbor, isConnected, n, visited);
        }
    }
}

int findCircleNum(int** isConnected, int isConnectedSize, int* isConnectedColSize) {
    int n = isConnectedSize;
    bool* visited = (bool*)calloc(n, sizeof(bool));
    int provinces = 0;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            provinces++;
            dfs(i, isConnected, n, visited);
        }
    }

    free(visited);
    return provinces;
}