#include <stdlib.h>
#include <string.h>

#define MAX_N 500

int graph[MAX_N][MAX_N];
int graphSize[MAX_N];
int visited[MAX_N];
int color[MAX_N];
int component[MAX_N];
int compSize;

int bfs(int start, int n) {
    int queue[MAX_N];
    int front = 0, rear = 0;
    int dist[MAX_N];
    memset(dist, -1, sizeof(dist));

    queue[rear++] = start;
    dist[start] = 0;
    int maxDist = 0;

    while (front < rear) {
        int node = queue[front++];
        for (int i = 0; i < graphSize[node]; i++) {
            int neighbor = graph[node][i];
            if (dist[neighbor] == -1) {
                dist[neighbor] = dist[node] + 1;
                maxDist = dist[neighbor];
                queue[rear++] = neighbor;
            }
        }
    }

    return maxDist + 1;
}

int dfs(int node, int c) {
    visited[node] = 1;
    color[node] = c;
    component[compSize++] = node;

    for (int i = 0; i < graphSize[node]; i++) {
        int neighbor = graph[node][i];
        if (!visited[neighbor]) {
            if (!dfs(neighbor, 1 - c)) {
                return 0;
            }
        } else if (color[neighbor] == color[node]) {
            return 0;
        }
    }
    return 1;
}

int magnificentSets(int n, int** edges, int edgesSize, int* edgesColSize) {
    for (int i = 0; i < n; i++) {
        graphSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        graph[u][graphSize[u]++] = v;
        graph[v][graphSize[v]++] = u;
    }

    memset(visited, 0, sizeof(visited));
    int result = 0;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            compSize = 0;
            if (!dfs(i, 0)) {
                return -1;
            }

            int maxGroups = 0;
            for (int j = 0; j < compSize; j++) {
                int groups = bfs(component[j], n);
                if (groups > maxGroups) {
                    maxGroups = groups;
                }
            }
            result += maxGroups;
        }
    }

    return result;
}