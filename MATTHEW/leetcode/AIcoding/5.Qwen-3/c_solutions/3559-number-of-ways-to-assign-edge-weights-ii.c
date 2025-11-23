#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* to;
    int* next;
} Edge;

long long pow2[100005];

long long dfs(int u, int parent, Edge* edges, int* head, int* depth, int* cnt, int* size, int n) {
    long long res = 1;
    size[u] = 1;
    for (int i = head[u]; i != -1; i = edges[i].next) {
        int v = edges[i].to;
        if (v == parent) continue;
        depth[v] = depth[u] + 1;
        long long child = dfs(v, u, edges, head, depth, cnt, size, n);
        res = (res * child) % 1000000007;
        size[u] += size[v];
    }
    return res;
}

long long countWays(int n, int** edgeList, int edgeListSize, int* edgeListColSize) {
    Edge* edges = (Edge*)malloc(2 * n * sizeof(Edge));
    int* head = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n - 1; ++i) {
        int u = edgeList[i][0];
        int v = edgeList[i][1];
        edges[2 * i].to = v;
        edges[2 * i].next = head[u];
        head[u] = 2 * i;
        edges[2 * i + 1].to = u;
        edges[2 * i + 1].next = head[v];
        head[v] = 2 * i + 1;
    }

    pow2[0] = 1;
    for (int i = 1; i <= 100000; ++i) {
        pow2[i] = (pow2[i - 1] * 2) % 1000000007;
    }

    int* depth = (int*)calloc(n, sizeof(int));
    int* cnt = (int*)calloc(n, sizeof(int));
    int* size = (int*)calloc(n, sizeof(int));

    dfs(0, -1, edges, head, depth, cnt, size, n);

    long long ans = 1;
    for (int i = 0; i < n; ++i) {
        if (size[i] > 1) {
            ans = (ans * pow2[size[i] - 1]) % 1000000007;
        }
    }

    free(edges);
    free(head);
    free(depth);
    free(cnt);
    free(size);
    return ans;
}