#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 105

int n, k;
int adj[MAXN][MAXN];
int distA[MAXN], distB[MAXN];
bool visited[MAXN];

void bfs(int start, int dist[]) {
    for (int i = 1; i <= n; i++) {
        dist[i] = -1;
        visited[i] = false;
    }

    int queue[MAXN], head = 0, tail = 0;
    queue[tail++] = start;
    dist[start] = 0;
    visited[start] = true;

    while (head < tail) {
        int u = queue[head++];
        for (int v = 1; v <= n; v++) {
            if (adj[u][v] && !visited[v]) {
                dist[v] = dist[u] + 1;
                visited[v] = true;
                queue[tail++] = v;
            }
        }
    }
}

int solve() {
    bfs(1, distA);
    bfs(n, distB);

    int maxDist = -1;
    for (int i = 1; i <= n; i++) {
        if (distB[i] != -1 && distA[i] > k) {
            if (maxDist == -1 || distB[i] > maxDist) {
                maxDist = distB[i];
            }
        }
    }

    return maxDist;
}