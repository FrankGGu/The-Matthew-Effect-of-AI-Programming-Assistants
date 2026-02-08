#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestPathValue(char * colors, int** edges, int edgesSize, int* edgesColSize) {
    int n = strlen(colors);
    int* inDegree = (int*)calloc(n, sizeof(int));
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSize = (int*)calloc(n, sizeof(int));
    int* adjCapacity = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        adjCapacity[i] = 2;
        adj[i] = (int*)malloc(adjCapacity[i] * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        inDegree[v]++;
        if (adjSize[u] == adjCapacity[u]) {
            adjCapacity[u] *= 2;
            adj[u] = (int*)realloc(adj[u], adjCapacity[u] * sizeof(int));
        }
        adj[u][adjSize[u]++] = v;
    }

    int* dp[n];
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)calloc(26, sizeof(int));
        dp[i][colors[i] - 'a'] = 1;
    }

    int queue[n];
    int head = 0, tail = 0;
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    int visited = 0;
    int ans = 0;
    while (head < tail) {
        int u = queue[head++];
        visited++;
        for (int i = 0; i < 26; i++) {
            if (dp[u][i] > ans) {
                ans = dp[u][i];
            }
        }

        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];
            for (int j = 0; j < 26; j++) {
                dp[v][j] = (dp[v][j] > dp[u][j] + (colors[v] - 'a' == j) ? dp[v][j] : dp[u][j] + (colors[v] - 'a' == j));
            }
            inDegree[v]--;
            if (inDegree[v] == 0) {
                queue[tail++] = v;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(dp[i]);
        free(adj[i]);
    }
    free(dp);
    free(inDegree);
    free(adj);
    free(adjSize);
    free(adjCapacity);

    return visited == n ? ans : -1;
}