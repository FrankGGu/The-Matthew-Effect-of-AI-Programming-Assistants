#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int capacity;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(capacity * sizeof(int));
    q->capacity = capacity;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    if (q->size < q->capacity) {
        q->data[q->size++] = value;
    }
}

int dequeue(Queue* q) {
    if (q->size > 0) {
        int val = q->data[0];
        for (int i = 0; i < q->size - 1; i++) {
            q->data[i] = q->data[i + 1];
        }
        q->size--;
        return val;
    }
    return -1;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int numBusesToDestination(int** routes, int routesSize, int* routesColSize, int source, int target) {
    if (source == target) return 0;

    int* visitedRoutes = (int*)calloc(routesSize, sizeof(int));
    int* visitedStops = (int*)calloc(100000, sizeof(int));

    Queue* queue = createQueue(routesSize);

    for (int i = 0; i < routesSize; i++) {
        for (int j = 0; j < routesColSize[i]; j++) {
            if (routes[i][j] == source) {
                enqueue(queue, i);
                visitedRoutes[i] = 1;
                break;
            }
        }
    }

    int buses = 0;

    while (queue->size > 0) {
        int size = queue->size;
        for (int i = 0; i < size; i++) {
            int route = dequeue(queue);
            for (int j = 0; j < routesColSize[route]; j++) {
                int stop = routes[route][j];
                if (stop == target) {
                    freeQueue(queue);
                    free(visitedRoutes);
                    free(visitedStops);
                    return buses;
                }
                if (visitedStops[stop] == 0) {
                    visitedStops[stop] = 1;
                    for (int k = 0; k < routesSize; k++) {
                        if (!visitedRoutes[k]) {
                            for (int l = 0; l < routesColSize[k]; l++) {
                                if (routes[k][l] == stop) {
                                    enqueue(queue, k);
                                    visitedRoutes[k] = 1;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
        buses++;
    }

    freeQueue(queue);
    free(visitedRoutes);
    free(visitedStops);
    return -1;
}