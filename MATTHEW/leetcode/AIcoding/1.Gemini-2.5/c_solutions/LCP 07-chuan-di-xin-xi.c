#include <stdlib.h>

typedef struct {
    int node;
    int steps;
} QueueItem;

int numWays(int n, int** relation, int relationSize, int* relationColSize, int k) {
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSizes = (int*)calloc(n, sizeof(int));
    int* adjCapacities = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        adjCapacities[i] = 4; 
        adj[i] = (int*)malloc(adjCapacities[i] * sizeof(int));
    }

    for (int i = 0; i < relationSize; i++) {
        int from = relation[i][0];
        int to = relation[i][1];

        if (adjSizes[from] == adjCapacities[from]) {
            adjCapacities[from] *= 2;
            adj[from] = (int*)realloc(adj[from], adjCapacities[from] * sizeof(int));
        }
        adj[from][adjSizes[from]++] = to;
    }

    QueueItem* q = (QueueItem*)malloc(1000 * sizeof(QueueItem));
    int head = 0;
    int tail = 0;

    q[tail++] = (QueueItem){.node = 0, .steps = 0};

    int count = 0;

    while (head < tail) {
        QueueItem current = q[head++];

        if (current.steps == k) {
            if (current.node == n - 1) {
                count++;
            }
            continue;
        }

        if (current.steps < k) {
            for (int i = 0; i < adjSizes[current.node]; i++) {
                int neighbor = adj[current.node][i];
                q[tail++] = (QueueItem){.node = neighbor, .steps = current.steps + 1};
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSizes);
    free(adjCapacities);
    free(q);

    return count;
}