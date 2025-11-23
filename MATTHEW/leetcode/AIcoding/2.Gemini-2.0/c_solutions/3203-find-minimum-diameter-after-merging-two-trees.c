#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 305

int n1, n2;
int u[MAXN * 2], v[MAXN * 2];
int adj[MAXN * 2][MAXN * 2], deg[MAXN * 2];
int dist[MAXN * 2][MAXN * 2];

void bfs(int start) {
    int queue[MAXN * 2], head = 0, tail = 0;
    int visited[MAXN * 2] = {0};

    queue[tail++] = start;
    visited[start] = 1;
    dist[start][start] = 0;

    while (head < tail) {
        int curr = queue[head++];
        for (int i = 0; i < deg[curr]; i++) {
            int neighbor = adj[curr][i];
            if (!visited[neighbor]) {
                visited[neighbor] = 1;
                dist[start][neighbor] = dist[start][curr] + 1;
                queue[tail++] = neighbor;
            }
        }
    }
}

int diameter(int n) {
    for (int i = 0; i < n; i++) {
        bfs(i);
    }

    int max_dist = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (dist[i][j] > max_dist) {
                max_dist = dist[i][j];
            }
        }
    }
    return max_dist;
}

int solve() {
    int diam1 = diameter(n1);
    int diam2 = diameter(n2);

    int max_dist1 = 0;
    int u1 = -1, v1 = -1;
    for (int i = 0; i < n1; i++) {
        for (int j = 0; j < n1; j++) {
            if (dist[i][j] > max_dist1) {
                max_dist1 = dist[i][j];
                u1 = i;
                v1 = j;
            }
        }
    }

    int max_dist2 = 0;
    int u2 = -1, v2 = -1;
    for (int i = 0; i < n2; i++) {
        for (int j = 0; j < n2; j++) {
            if (dist[i][j] > max_dist2) {
                max_dist2 = dist[i][j];
                u2 = i;
                v2 = j;
            }
        }
    }

    int rad1 = INT_MAX;
    for (int i = 0; i < n1; i++) {
        int max_d = 0;
        for (int j = 0; j < n1; j++) {
            if (dist[i][j] > max_d) {
                max_d = dist[i][j];
            }
        }
        if (max_d < rad1) {
            rad1 = max_d;
        }
    }

    int rad2 = INT_MAX;
    for (int i = 0; i < n2; i++) {
        int max_d = 0;
        for (int j = 0; j < n2; j++) {
            if (dist[i][j] > max_d) {
                max_d = dist[i][j];
            }
        }
        if (max_d < rad2) {
            rad2 = max_d;
        }
    }

    int ans = INT_MAX;
    for (int i = 0; i < n1; i++) {
        for (int j = 0; j < n2; j++) {
            int new_diam = 1 + rad1 + rad2;
            if (new_diam < ans) ans = new_diam;

            int case1 = dist[i][u1] > dist[i][v1] ? dist[i][u1] : dist[i][v1];
            int case2 = dist[j][u2] > dist[j][v2] ? dist[j][u2] : dist[j][v2];
            int case3 = case1 + 1 + case2;

            if (case3 > diam1 && case3 > diam2 && case3 < ans) ans = case3;
            if (diam1 > diam2 && diam1 > case3 && diam1 < ans) ans = diam1;
            if (diam2 > diam1 && diam2 > case3 && diam2 < ans) ans = diam2;
        }
    }

    return ans;
}

int findMinHeightTrees(int n1_, int edges1[][2], int edges1Size, int* edges1ColSize, int n2_, int edges2[][2], int edges2Size, int* edges2ColSize) {
    n1 = n1_;
    n2 = n2_;

    for (int i = 0; i < n1 + n2; i++) {
        deg[i] = 0;
        for (int j = 0; j < n1 + n2; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    for (int i = 0; i < edges1Size; i++) {
        int a = edges1[i][0];
        int b = edges1[i][1];
        adj[a][deg[a]++] = b;
        adj[b][deg[b]++] = a;
    }

    for (int i = 0; i < edges2Size; i++) {
        int a = edges2[i][0] + n1;
        int b = edges2[i][1] + n1;
        adj[a][deg[a]++] = b;
        adj[b][deg[b]++] = a;
    }

    return solve();
}