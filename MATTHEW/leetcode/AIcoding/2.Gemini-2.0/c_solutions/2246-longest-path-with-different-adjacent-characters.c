#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPath(int* parent, int parentSize, char* s) {
    int n = parentSize + 1;
    int* adj[n];
    int* adjSize = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 1; i < n; i++) {
        adj[parent[i - 1]][adjSize[parent[i - 1]]] = i;
        adjSize[parent[i - 1]]++;
        adj[i][adjSize[i]] = parent[i - 1];
        adjSize[i]++;
    }

    int max_len = 1;

    int dfs(int node, int par) {
        int max1 = 0, max2 = 0;
        for (int i = 0; i < adjSize[node]; i++) {
            int neighbor = adj[node][i];
            if (neighbor != par) {
                int len = dfs(neighbor, node);
                if (s[node] != s[neighbor]) {
                    if (len > max1) {
                        max2 = max1;
                        max1 = len;
                    } else if (len > max2) {
                        max2 = len;
                    }
                }
            }
        }
        max_len = (max_len > (max1 + max2 + 1)) ? max_len : (max1 + max2 + 1);
        return max1 + 1;
    }

    dfs(0, -1);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adjSize);

    return max_len;
}