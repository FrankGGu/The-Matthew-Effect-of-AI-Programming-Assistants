#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countSubTrees(int n, int** edges, int edgesSize, int* edgesColSize, char* labels, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    for (int i = 0; i < n; i++) {
        result[i] = 0;
    }

    int* adj[n];
    int adj_size[n];
    for (int i = 0; i < n; i++) {
        adj_size[i] = 0;
        adj[i] = (int*)malloc(2 * n * sizeof(int)); 
    }

    for (int i = 0; i < edgesSize; i++) {
        adj[edges[i][0]][adj_size[edges[i][0]]++] = edges[i][1];
        adj[edges[i][1]][adj_size[edges[i][1]]++] = edges[i][0];
    }

    int* dfs(int node, int parent) {
        int* counts = (int*)calloc(26, sizeof(int));
        counts[labels[node] - 'a'] = 1;
        result[node] = 1;

        for (int i = 0; i < adj_size[node]; i++) {
            int neighbor = adj[node][i];
            if (neighbor != parent) {
                int* child_counts = dfs(neighbor, node);
                for (int j = 0; j < 26; j++) {
                    counts[j] += child_counts[j];
                }
                free(child_counts);
            }
        }

        result[node] = counts[labels[node] - 'a'];
        return counts;
    }

    dfs(0, -1);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }

    return result;
}