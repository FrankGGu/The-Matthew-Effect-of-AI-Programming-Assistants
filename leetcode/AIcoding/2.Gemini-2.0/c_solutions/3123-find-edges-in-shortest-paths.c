#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 200

int n, m;
int adj[MAXN][MAXN];
int dist[MAXN];
int par[MAXN];
bool edgeInSP[MAXN][MAXN];

void bfs(int start) {
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
        par[i] = -1;
    }
    dist[start] = 0;
    int queue[MAXN];
    int head = 0, tail = 0;
    queue[tail++] = start;

    while (head < tail) {
        int u = queue[head++];
        for (int v = 0; v < n; v++) {
            if (adj[u][v] && dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[tail++] = v;
                par[v] = u;
            } else if (adj[u][v] && dist[v] == dist[u] + 1) {
            }
        }
    }
}

int* findEdgesInShortestPaths(int n_val, int m_val, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    n = n_val;
    m = m_val;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj[i][j] = 0;
            edgeInSP[i][j] = false;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][v] = 1;
        adj[v][u] = 1;
    }

    for (int i = 0; i < n; i++) {
        bfs(i);
        for (int j = 0; j < n; j++) {
            if (i != j && dist[j] > 0) {
                int queue[MAXN];
                int head = 0, tail = 0;
                queue[tail++] = j;
                bool visited[MAXN];
                for(int k = 0; k < n; k++) visited[k] = false;
                visited[j] = true;

                while(head < tail){
                    int u = queue[head++];
                    if(u == i) continue;

                    for(int v = 0; v < n; v++){
                        if(adj[u][v] && dist[u] == dist[v] + 1){
                            edgeInSP[u][v] = true;
                            edgeInSP[v][u] = true;
                            if(!visited[v]){
                                queue[tail++] = v;
                                visited[v] = true;
                            }
                        }
                    }
                }
            }
        }
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (adj[i][j] && edgeInSP[i][j]) {
                count++;
            }
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    int index = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (adj[i][j] && edgeInSP[i][j]) {
                result[index++] = i * n + j;
            }
        }
    }

    *returnSize = count;
    return result;
}