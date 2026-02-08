#define MOD 1000000007
#include <stdlib.h>

typedef struct {
    int node;
    long long dist;
} Node;

int cmp(const void *a, const void *b) {
    return ((Node *)a)->dist - ((Node *)b)->dist;
}

long long dijkstra(int n, int** roads, int roadsSize, int* roadsColSize) {
    long long *dist = (long long *)calloc(n, sizeof(long long));
    long long *ways = (long long *)calloc(n, sizeof(long long));
    for (int i = 0; i < n; i++) dist[i] = LLONG_MAX;
    dist[0] = 0;
    ways[0] = 1;

    Node *minHeap = (Node *)malloc(n * sizeof(Node));
    int heapSize = 0;

    minHeap[heapSize++] = (Node){0, 0};

    while (heapSize > 0) {
        qsort(minHeap, heapSize, sizeof(Node), cmp);
        Node current = minHeap[0];
        memmove(minHeap, minHeap + 1, (heapSize - 1) * sizeof(Node));
        heapSize--;

        for (int i = 0; i < roadsSize; i++) {
            if (roads[i][0] == current.node || roads[i][1] == current.node) {
                int neighbor = roads[i][0] == current.node ? roads[i][1] : roads[i][0];
                long long newDist = current.dist + roads[i][2];
                if (newDist < dist[neighbor]) {
                    dist[neighbor] = newDist;
                    ways[neighbor] = ways[current.node];
                    minHeap[heapSize++] = (Node){neighbor, newDist};
                } else if (newDist == dist[neighbor]) {
                    ways[neighbor] = (ways[neighbor] + ways[current.node]) % MOD;
                }
            }
        }
    }

    free(dist);
    free(ways);
    free(minHeap);
    return ways[n - 1];
}

int countPaths(int n, int** roads, int roadsSize, int* roadsColSize) {
    return (int)dijkstra(n, roads, roadsSize, roadsColSize);
}