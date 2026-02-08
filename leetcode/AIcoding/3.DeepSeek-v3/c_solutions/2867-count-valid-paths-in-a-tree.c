/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

#include <stdlib.h>
#include <stdbool.h>

#define MAX_N 100001

bool isPrime[MAX_N];
int parent[MAX_N];
int size[MAX_N];
int* graph[MAX_N];
int graphSize[MAX_N];
int graphCapacity[MAX_N];

void sieve() {
    for (int i = 0; i < MAX_N; i++) {
        isPrime[i] = true;
    }
    isPrime[0] = isPrime[1] = false;
    for (int i = 2; i * i < MAX_N; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j < MAX_N; j += i) {
                isPrime[j] = false;
            }
        }
    }
}

int find(int x) {
    if (parent[x] != x) {
        parent[x] = find(parent[x]);
    }
    return parent[x];
}

void unionSets(int a, int b) {
    int rootA = find(a);
    int rootB = find(b);
    if (rootA != rootB) {
        if (size[rootA] < size[rootB]) {
            parent[rootA] = rootB;
            size[rootB] += size[rootA];
        } else {
            parent[rootB] = rootA;
            size[rootA] += size[rootB];
        }
    }
}

void addEdge(int u, int v) {
    if (graphSize[u] >= graphCapacity[u]) {
        graphCapacity[u] = graphCapacity[u] == 0 ? 2 : graphCapacity[u] * 2;
        graph[u] = realloc(graph[u], graphCapacity[u] * sizeof(int));
    }
    graph[u][graphSize[u]++] = v;
}

long long countPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    sieve();

    for (int i = 1; i <= n; i++) {
        parent[i] = i;
        size[i] = 1;
        graph[i] = NULL;
        graphSize[i] = 0;
        graphCapacity[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(u, v);
        addEdge(v, u);

        if (!isPrime[u] && !isPrime[v]) {
            unionSets(u, v);
        }
    }

    long long result = 0;

    for (int i = 1; i <= n; i++) {
        if (!isPrime[i]) continue;

        long long total = 0;
        long long sumSizes = 0;

        for (int j = 0; j < graphSize[i]; j++) {
            int neighbor = graph[i][j];
            if (isPrime[neighbor]) continue;

            int root = find(neighbor);
            long long compSize = size[root];

            result += compSize * total;
            total += compSize;
        }

        result += total;
    }

    for (int i = 1; i <= n; i++) {
        if (graph[i] != NULL) {
            free(graph[i]);
        }
    }

    return result;
}