#include <stdbool.h>
#include <stdlib.h>

void dfs(int city, int n, int** isConnected, bool* visited) {
    visited[city] = true;
    for (int neighbor = 0; neighbor < n; neighbor++) {
        if (isConnected[city][neighbor] == 1 && !visited[neighbor]) {
            dfs(neighbor, n, isConnected, visited);
        }
    }
}

int findCircleNum(int** isConnected, int isConnectedSize, int* isConnectedColSize) {
    int n = isConnectedSize;
    bool* visited = (bool*)calloc(n, sizeof(bool));
    if (visited == NULL) {
        return 0; 
    }

    int provinces = 0;
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            provinces++;
            dfs(i, n, isConnected, visited);
        }
    }

    free(visited);
    return provinces;
}