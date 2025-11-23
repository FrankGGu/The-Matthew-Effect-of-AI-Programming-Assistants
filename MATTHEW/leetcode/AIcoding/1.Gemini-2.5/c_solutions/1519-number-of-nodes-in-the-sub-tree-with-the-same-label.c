#include <stdlib.h>
#include <string.h>

int* dfs(int u, int parent, int n, int** adj, int* adjSizes, char* labels, int* ans) {
    int* counts = (int*)calloc(26, sizeof(int));

    for (int i = 0; i < adjSizes[u]; i++) {
        int v = adj[u][i];
        if (v == parent) {
            continue;
        }

        int* child_counts = dfs(v, u, n, adj, adjSizes, labels, ans);
        for (int j = 0; j < 26; j++) {
            counts[j] += child_counts[j];
        }
        free(child_counts);
    }

    int label_idx = labels[u] - 'a';
    counts[label_idx]++;

    ans[u] = counts[label_idx];

    return counts;
}

int* countSubTrees(int n, int** edges, int edgesSize, int* edgesColSize, char* labels, int* returnSize) {
    *returnSize = n;
    int* ans = (int*)malloc(n * sizeof(int));

    int* degree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        degree[edges[i][0]]++;
        degree[edges[i][1]]++;
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSizes = (int*)malloc(n * sizeof(int));

    int total_neighbors = 0;
    for(int i = 0; i < n; i++) {
        total_neighbors += degree[i];
    }
    int* adjData = (int*)malloc(total_neighbors * sizeof(int));

    int current_offset = 0;
    for (int i = 0; i < n; i++) {
        adj[i] = adjData + current_offset;
        adjSizes[i] = 0;
        current_offset += degree[i];
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSizes[u]++] = v;
        adj[v][adjSizes[v]++] = u;
    }

    int* final_counts = dfs(0, -1, n, adj, adjSizes, labels, ans);
    free(final_counts);

    free(degree);
    free(adjData);
    free(adj);
    free(adjSizes);

    return ans;
}