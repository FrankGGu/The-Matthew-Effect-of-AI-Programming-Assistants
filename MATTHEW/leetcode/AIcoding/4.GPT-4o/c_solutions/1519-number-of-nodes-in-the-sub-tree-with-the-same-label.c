#include <stdio.h>
#include <stdlib.h>

#define MAX_N 100000

int count[MAX_N];
int result[MAX_N];
int *graph[MAX_N];

void dfs(int node, int parent, char *labels) {
    int label = labels[node] - 'a';
    count[label]++;

    for (int i = 0; i < graph[node][0]; i++) {
        int neighbor = graph[node][i + 1];
        if (neighbor != parent) {
            dfs(neighbor, node, labels);
        }
    }

    result[node] = count[label];
    count[label]--;
}

int* countSubTrees(int n, int** edges, int edgesSize, char * labels, int* returnSize) {
    *returnSize = n;
    for (int i = 0; i < n; i++) {
        graph[i] = (int *)malloc((n + 1) * sizeof(int));
        graph[i][0] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graph[u][++graph[u][0]] = v;
        graph[v][++graph[v][0]] = u;
    }

    dfs(0, -1, labels);

    return result;
}