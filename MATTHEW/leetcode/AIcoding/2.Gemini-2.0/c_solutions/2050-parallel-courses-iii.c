#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

int max(int a, int b) {
    return (a > b) ? a : b;
}

int minimumTime(int n, int** relations, int relationsSize, int* relationsColSize, int* time, int timeSize) {
    int indegree[MAXN] = {0};
    int dist[MAXN] = {0};
    int adj[MAXN][100] = {0};
    int adjSize[MAXN] = {0};

    for (int i = 0; i < relationsSize; i++) {
        int prevCourse = relations[i][0];
        int nextCourse = relations[i][1];
        adj[prevCourse][adjSize[prevCourse]++] = nextCourse;
        indegree[nextCourse]++;
    }

    int queue[MAXN];
    int front = 0, rear = 0;

    for (int i = 1; i <= n; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
            dist[i] = time[i - 1];
        }
    }

    while (front < rear) {
        int u = queue[front++];
        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];
            dist[v] = max(dist[v], dist[u] + time[v - 1]);
            indegree[v]--;
            if (indegree[v] == 0) {
                queue[rear++] = v;
            }
        }
    }

    int maxTime = 0;
    for (int i = 1; i <= n; i++) {
        maxTime = max(maxTime, dist[i]);
    }

    return maxTime;
}