#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 16

int adj[MAXN][MAXN];
int n;
int ans[MAXN];

int bfs(int mask, int start_node) {
    int dist[MAXN];
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }
    dist[start_node] = 0;
    int queue[MAXN];
    int head = 0, tail = 0;
    queue[tail++] = start_node;

    while (head < tail) {
        int u = queue[head++];
        for (int v = 0; v < n; v++) {
            if (adj[u][v] && (mask & (1 << v)) && dist[v] == -1) {
                dist[v] = dist[u] + 1;
                queue[tail++] = v;
            }
        }
    }

    int max_dist = 0;
    for (int i = 0; i < n; i++) {
        if (mask & (1 << i)) {
            if (dist[i] == -1) return -1;
            max_dist = (dist[i] > max_dist) ? dist[i] : max_dist;
        }
    }

    return max_dist;
}

int solve(int mask) {
    int nodes_count = 0;
    int start_node = -1;
    for (int i = 0; i < n; i++) {
        if (mask & (1 << i)) {
            nodes_count++;
            if (start_node == -1) start_node = i;
        }
    }

    if (nodes_count < 2) return -1;

    int diameter = 0;
    for (int i = 0; i < n; i++) {
        if (mask & (1 << i)) {
            int max_dist = bfs(mask, i);
            if (max_dist == -1) return -1;

            int farthest_node = i;
            int dist[MAXN];
            for (int j = 0; j < n; j++) {
                dist[j] = -1;
            }
            dist[i] = 0;
            int queue[MAXN];
            int head = 0, tail = 0;
            queue[tail++] = i;

            while (head < tail) {
                int u = queue[head++];
                for (int v = 0; v < n; v++) {
                    if (adj[u][v] && (mask & (1 << v)) && dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        queue[tail++] = v;
                    }
                }
            }

            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) && dist[j] > dist[farthest_node]) {
                    farthest_node = j;
                }
            }

            for (int j = 0; j < n; j++) {
                dist[j] = -1;
            }
            dist[farthest_node] = 0;
            head = 0;
            tail = 0;
            queue[tail++] = farthest_node;

            while (head < tail) {
                int u = queue[head++];
                for (int v = 0; v < n; v++) {
                    if (adj[u][v] && (mask & (1 << v)) && dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        queue[tail++] = v;
                    }
                }
            }

            for (int j = 0; j < n; j++) {
                if ((mask & (1 << j)) && dist[j] > diameter) {
                    diameter = dist[j];
                }
            }
        }
    }

    return diameter;
}

int* countSubtrees(int n_in, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    n = n_in;
    memset(adj, 0, sizeof(adj));
    memset(ans, 0, sizeof(ans));

    for (int i = 0; i < edgesSize; i++) {
        adj[edges[i][0] - 1][edges[i][1] - 1] = 1;
        adj[edges[i][1] - 1][edges[i][0] - 1] = 1;
    }

    for (int mask = 1; mask < (1 << n); mask++) {
        int diameter = solve(mask);
        if (diameter != -1) {
            ans[diameter]++;
        }
    }

    *returnSize = n - 1;
    return ans + 1;
}