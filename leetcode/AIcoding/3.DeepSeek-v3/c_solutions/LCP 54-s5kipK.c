#include <stdlib.h>
#include <string.h>

#define MAX_N 100000
#define MAX_M 200000

typedef struct {
    int to, next;
} Edge;

Edge edges[MAX_M * 2];
int head[MAX_N + 1], edgeCount;
int degree[MAX_N + 1];
int queue[MAX_N], front, rear;
long long minPower[MAX_N + 1];

void addEdge(int u, int v) {
    edges[edgeCount].to = v;
    edges[edgeCount].next = head[u];
    head[u] = edgeCount++;
    degree[v]++;
}

long long* minimumPower(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    edgeCount = 0;
    memset(head, -1, sizeof(head));
    memset(degree, 0, sizeof(degree));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(u, v);
        addEdge(v, u);
    }

    front = rear = 0;
    for (int i = 1; i <= n; i++) {
        minPower[i] = 1;
        if (degree[i] == 1) {
            queue[rear++] = i;
        }
    }

    long long* result = (long long*)malloc(n * sizeof(long long));
    *returnSize = n;

    while (front < rear) {
        int u = queue[front++];
        result[u - 1] = minPower[u];

        for (int i = head[u]; i != -1; i = edges[i].next) {
            int v = edges[i].to;
            if (degree[v] > 1) {
                minPower[v] += minPower[u];
                degree[v]--;
                if (degree[v] == 1) {
                    queue[rear++] = v;
                }
            }
        }
    }

    return result;
}