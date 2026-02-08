#include <stdlib.h>
#include <string.h>

typedef struct {
    int node;
    int weight;
    int next;
} Edge;

Edge edges[200000];
int head[50000];
int edgeCount = 0;

void addEdge(int u, int v, int w) {
    edges[edgeCount].node = v;
    edges[edgeCount].weight = w;
    edges[edgeCount].next = head[u];
    head[u] = edgeCount++;
}

int cmp(const void* a, const void* b) {
    long long diff = *(long long*)b - *(long long*)a;
    return diff > 0 ? 1 : (diff < 0 ? -1 : 0);
}

int dfs(int node, int parent, int* degree, long long* result) {
    int count = 1;
    long long* weights = (long long*)malloc(degree[node] * sizeof(long long));
    int idx = 0;

    for (int i = head[node]; i != -1; i = edges[i].next) {
        int child = edges[i].node;
        if (child == parent) continue;

        int childCount = dfs(child, node, degree, result);
        count += childCount;

        long long contribution = (long long)edges[i].weight * childCount;
        weights[idx++] = contribution;
    }

    qsort(weights, idx, sizeof(long long), cmp);

    int removals = degree[node] - (node == 0 ? 0 : 1);
    for (int i = 0; i < idx && i < removals; i++) {
        *result += weights[i];
    }

    free(weights);
    return count;
}

long long maximumScoreAfterOperations(int** edgesArray, int edgesSize, int* edgesColSize, int* weights, int weightsSize) {
    int n = weightsSize;
    edgeCount = 0;
    memset(head, -1, sizeof(head));

    int* degree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        int u = edgesArray[i][0];
        int v = edgesArray[i][1];
        addEdge(u, v, weights[i]);
        addEdge(v, u, weights[i]);
        degree[u]++;
        degree[v]++;
    }

    long long total = 0;
    for (int i = 0; i < weightsSize; i++) {
        total += weights[i];
    }

    long long removedSum = 0;
    dfs(0, -1, degree, &removedSum);

    free(degree);
    return total - removedSum;
}