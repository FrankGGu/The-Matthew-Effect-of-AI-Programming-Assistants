#include <stdbool.h>
#include <stdlib.h> 
#include <string.h> 

typedef struct {
    int* data;
    int front;
    int rear;
    int capacity;
    int size;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->data = (int*)malloc(sizeof(int) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, int item) {
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = item;
    q->size++;
}

int dequeue(Queue* q) {
    int item = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return item;
}

bool isQueueEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int countCompleteComponents(int n, int** edges, int edgesSize, int* edgesColSize) {
    bool** adj = (bool**)malloc(sizeof(bool*) * n);
    for (int i = 0; i < n; ++i) {
        adj[i] = (bool*)calloc(n, sizeof(bool)); 
    }

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][v] = true;
        adj[v][u] = true; 
    }

    bool* visited = (bool*)calloc(n, sizeof(bool)); 
    int complete_components_count = 0;

    Queue* q = createQueue(n);

    for (int i = 0; i < n; ++i) {
        if (!visited[i]) {
            int vertices_in_component = 0;
            long long edges_in_component_sum_degrees = 0; 

            enqueue(q, i);
            visited[i] = true;
            vertices_in_component++;

            while (!isQueueEmpty(q)) {
                int u = dequeue(q);

                for (int v = 0; v < n; ++v) {
                    if (adj[u][v]) { 
                        edges_in_component_sum_degrees++; 
                        if (!visited[v]) {
                            visited[v] = true;
                            enqueue(q, v);
                            vertices_in_component++;
                        }
                    }
                }
            }

            long long actual_edges = edges_in_component_sum_degrees / 2;

            long long expected_edges = (long long)vertices_in_component * (vertices_in_component - 1) / 2;

            if (actual_edges == expected_edges) {
                complete_components_count++;
            }
        }
    }

    freeQueue(q);
    free(visited);
    for (int i = 0; i < n; ++i) {
        free(adj[i]);
    }
    free(adj);

    return complete_components_count;
}