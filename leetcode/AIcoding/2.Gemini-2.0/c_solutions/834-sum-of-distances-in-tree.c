#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* sumOfDistancesInTree(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize){
    int *ans = (int*)malloc(sizeof(int) * n);
    int *size = (int*)malloc(sizeof(int) * n);
    int *dp = (int*)malloc(sizeof(int) * n);
    int **graph = (int**)malloc(sizeof(int*) * n);
    int *graphSize = (int*)malloc(sizeof(int) * n);
    for(int i = 0; i < n; i++){
        graph[i] = (int*)malloc(sizeof(int) * n);
        graphSize[i] = 0;
    }

    for(int i = 0; i < edgesSize; i++){
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    for(int i = 0; i < n; i++) size[i] = 0;

    void dfs1(int u, int p){
        size[u] = 1;
        dp[u] = 0;
        for(int i = 0; i < graphSize[u]; i++){
            int v = graph[u][i];
            if(v != p){
                dfs1(v, u);
                size[u] += size[v];
                dp[u] += dp[v] + size[v];
            }
        }
    }

    dfs1(0, -1);

    ans[0] = dp[0];

    void dfs2(int u, int p){
        for(int i = 0; i < graphSize[u]; i++){
            int v = graph[u][i];
            if(v != p){
                ans[v] = ans[u] - size[v] + n - size[v];
                dfs2(v, u);
            }
        }
    }

    dfs2(0, -1);

    *returnSize = n;

    for(int i = 0; i < n; i++){
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(size);
    free(dp);
    return ans;
}