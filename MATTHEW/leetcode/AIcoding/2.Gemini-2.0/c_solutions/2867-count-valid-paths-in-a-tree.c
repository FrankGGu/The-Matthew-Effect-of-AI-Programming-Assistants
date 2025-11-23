#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

int countPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* isPrime = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        isPrime[i] = 1;
    }
    isPrime[0] = isPrime[1] = 0;
    for (int p = 2; p * p <= n; p++) {
        if (isPrime[p]) {
            for (int i = p * p; i <= n; i += p) {
                isPrime[i] = 0;
            }
        }
    }

    int** adj = (int**)malloc((n + 1) * sizeof(int*));
    int* adjSize = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        adjSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
    }

    long long totalPaths = 0;
    int* visited = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 1; i <= n; i++) {
        if (isPrime[i]) {
            for (int j = 0; j <= n; j++) {
                visited[j] = 0;
            }
            visited[i] = 1;

            long long pathsFromComponent = 0;
            for (int j = 0; j < adjSize[i]; j++) {
                int neighbor = adj[i][j];
                if (!isPrime[neighbor]) {
                    long long componentSize = 1;
                    int* stack = (int*)malloc(n * sizeof(int));
                    int top = 0;
                    stack[top++] = neighbor;
                    visited[neighbor] = 1;

                    while (top > 0) {
                        int u = stack[--top];
                        componentSize++;

                        for (int k = 0; k < adjSize[u]; k++) {
                            int v = adj[u][k];
                            if (!isPrime[v] && !visited[v]) {
                                visited[v] = 1;
                                stack[top++] = v;
                            }
                        }
                    }
                    free(stack);
                    pathsFromComponent = (pathsFromComponent + componentSize) % MOD;
                }
            }
            totalPaths = (totalPaths + pathsFromComponent) % MOD;

            long long combinations = 0;
            for (int j = 0; j <= n; j++) {
                visited[j] = 0;
            }
            visited[i] = 1;

            long long componentSizes[n];
            int numComponents = 0;

            for (int j = 0; j < adjSize[i]; j++) {
                int neighbor = adj[i][j];
                if (!isPrime[neighbor]) {
                    long long componentSize = 1;
                    int* stack = (int*)malloc(n * sizeof(int));
                    int top = 0;
                    stack[top++] = neighbor;
                    visited[neighbor] = 1;

                    while (top > 0) {
                        int u = stack[--top];
                        componentSize++;

                        for (int k = 0; k < adjSize[u]; k++) {
                            int v = adj[u][k];
                            if (!isPrime[v] && !visited[v]) {
                                visited[v] = 1;
                                stack[top++] = v;
                            }
                        }
                    }
                    free(stack);
                    componentSizes[numComponents++] = componentSize;
                }
            }

            for (int j = 0; j < numComponents; j++) {
                for (int k = j + 1; k < numComponents; k++) {
                    combinations = (combinations + (componentSizes[j] * componentSizes[k]) % MOD) % MOD;
                }
            }

            totalPaths = (totalPaths + combinations) % MOD;
        }
    }

    for (int i = 0; i <= n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSize);
    free(isPrime);
    free(visited);

    return (int)totalPaths;
}