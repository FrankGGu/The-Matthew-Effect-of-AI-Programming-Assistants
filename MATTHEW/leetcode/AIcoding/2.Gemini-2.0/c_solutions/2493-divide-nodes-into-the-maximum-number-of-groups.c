#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

int color[MAXN];
int adj[MAXN];
int next_node[MAXN];
int head[MAXN];
int dist[MAXN];
int n, m;

void add_edge(int u, int v) {
    adj[m] = v;
    next_node[m] = head[u];
    head[u] = m++;
}

int dfs(int u, int c) {
    color[u] = c;
    for (int i = head[u]; i != -1; i = next_node[i]) {
        int v = adj[i];
        if (color[v] == 0) {
            if (!dfs(v, 3 - c)) {
                return 0;
            }
        } else if (color[v] == c) {
            return 0;
        }
    }
    return 1;
}

int bfs(int start) {
    for (int i = 1; i <= n; i++) {
        dist[i] = -1;
    }
    dist[start] = 0;
    int queue[MAXN];
    int front = 0, rear = 0;
    queue[rear++] = start;

    int max_dist = 0;
    while (front < rear) {
        int u = queue[front++];
        max_dist = dist[u];
        for (int i = head[u]; i != -1; i = next_node[i]) {
            int v = adj[i];
            if (dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[rear++] = v;
            }
        }
    }
    return max_dist;
}

int maximumGroups(int n, int** edges, int edgesSize, int* edgesColSize) {
    m = 0;
    for (int i = 1; i <= n; i++) {
        head[i] = -1;
        color[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v);
        add_edge(v, u);
    }

    int is_bipartite = 1;
    for (int i = 1; i <= n; i++) {
        if (color[i] == 0) {
            if (!dfs(i, 1)) {
                is_bipartite = 0;
                break;
            }
        }
    }

    if (!is_bipartite) {
        return -1;
    }

    int ans = 0;
    for (int i = 1; i <= n; i++) {
        ans = fmax(ans, bfs(i));
    }

    return ans + 1;
}