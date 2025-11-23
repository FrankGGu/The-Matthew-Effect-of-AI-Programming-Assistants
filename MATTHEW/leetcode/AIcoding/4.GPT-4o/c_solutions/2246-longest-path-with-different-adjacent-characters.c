#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dfs(int node, int parent, int* graph, char* s, int** adj, int* maxLength) {
    int first = 0, second = 0;
    for (int i = 0; i < graph[node]; i++) {
        int neighbor = adj[node][i];
        if (neighbor == parent) continue;
        int length = dfs(neighbor, node, graph, s, adj, maxLength);
        if (s[node] != s[neighbor]) {
            if (length > first) {
                second = first;
                first = length;
            } else if (length > second) {
                second = length;
            }
        }
    }
    *maxLength = fmax(*maxLength, first + second + 1);
    return first + 1;
}

int longestPath(char * s, int** edges, int edgesSize, int* edgesColSize) {
    int n = strlen(s);
    int* graph = (int*)calloc(n, sizeof(int));
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        adj[u][graph[u]++] = v;
        adj[v][graph[v]++] = u;
    }

    int maxLength = 0;
    dfs(0, -1, graph, s, adj, &maxLength);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(graph);

    return maxLength;
}