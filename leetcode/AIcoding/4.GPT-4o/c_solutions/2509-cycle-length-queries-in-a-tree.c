#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *parent;
    int **tree;
    int *depth;
    int *size;
    int *h;
    int *answers;
} Solution;

void dfs(Solution *sol, int node, int parent) {
    sol->size[node] = 1;
    sol->h[node] = 1;
    for (int i = 0; i < sol->tree[node][0]; i++) {
        int child = sol->tree[node][i + 1];
        if (child != parent) {
            sol->depth[child] = sol->depth[node] + 1;
            dfs(sol, child, node);
            sol->size[node] += sol->size[child];
            sol->h[node] = sol->h[node] > sol->h[child] + 1 ? sol->h[node] : sol->h[child] + 1;
        }
    }
}

int cycleLength(int n, int node, int *depth, int *parent) {
    int cycle = 0;
    while (depth[node] != 0) {
        cycle++;
        node = parent[node];
    }
    return cycle;
}

int* cycleLengthQueries(int n, int edges[][2], int edgesSize, int** queries, int queriesSize, int* returnSize) {
    Solution *sol = (Solution *)malloc(sizeof(Solution));
    sol->parent = (int *)malloc(n * sizeof(int));
    sol->tree = (int **)malloc(n * sizeof(int *));
    sol->depth = (int *)calloc(n, sizeof(int));
    sol->size = (int *)calloc(n, sizeof(int));
    sol->h = (int *)calloc(n, sizeof(int));
    sol->answers = (int *)malloc(queriesSize * sizeof(int));

    for (int i = 0; i < n; i++) {
        sol->tree[i] = (int *)malloc((n + 1) * sizeof(int));
        sol->tree[i][0] = 0;
        sol->parent[i] = -1;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        sol->tree[u][++sol->tree[u][0]] = v;
        sol->tree[v][++sol->tree[v][0]] = u;
        sol->parent[v] = u;
    }

    dfs(sol, 0, -1);

    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int b = queries[i][1];
        int cycle = 0;
        int lengthA = cycleLength(n, a, sol->depth, sol->parent);
        int lengthB = cycleLength(n, b, sol->depth, sol->parent);
        cycle = lengthA + lengthB;
        sol->answers[i] = cycle;
    }

    *returnSize = queriesSize;
    return sol->answers;
}