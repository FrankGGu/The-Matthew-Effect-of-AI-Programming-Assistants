#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int room;
    long long time;
} Pair;

int comparePairs(const void *a, const void *b) {
    return ((Pair*)a)->time - ((Pair*)b)->time;
}

long long minimumTime(int n, int corridors[][2], int corridorsSize, int* corridorsColSize, int maxTime) {
    int* degree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < corridorsSize; i++) {
        degree[corridors[i][0] - 1]++;
        degree[corridors[i][1] - 1]++;
    }

    long long* dist = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }
    dist[0] = 0;

    bool* visited = (bool*)calloc(n, sizeof(bool));
    Pair* queue = (Pair*)malloc(n * sizeof(Pair));
    int head = 0, tail = 0;
    queue[tail].room = 0;
    queue[tail].time = 0;
    tail++;

    while (head < tail) {
        Pair current = queue[head++];
        int u = current.room;
        long long time = current.time;

        if (visited[u]) continue;
        visited[u] = true;

        for (int i = 0; i < corridorsSize; i++) {
            int v = -1;
            if (corridors[i][0] - 1 == u) {
                v = corridors[i][1] - 1;
            } else if (corridors[i][1] - 1 == u) {
                v = corridors[i][0] - 1;
            }

            if (v != -1) {
                long long arrivalTime = time + 1;
                if (u != 0) {
                    arrivalTime = arrivalTime + arrivalTime % maxTime == 0 ? 0 : maxTime - arrivalTime % maxTime;
                }

                if (dist[v] == -1 || arrivalTime < dist[v]) {
                    dist[v] = arrivalTime;
                    queue[tail].room = v;
                    queue[tail].time = arrivalTime;
                    tail++;
                }
            }
        }
    }

    long long result = dist[n - 1];
    free(degree);
    free(dist);
    free(visited);
    free(queue);
    return result;
}