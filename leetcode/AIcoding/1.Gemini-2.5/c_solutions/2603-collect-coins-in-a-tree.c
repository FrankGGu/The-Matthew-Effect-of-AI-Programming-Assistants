#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct AdjListNode {
    int dest;
    struct AdjListNode* next;
} AdjListNode;

typedef struct AdjList {
    AdjListNode* head;
} AdjList;

typedef struct Graph {
    int V;
    AdjList* array;
} Graph;

AdjListNode* newAdjListNode(int dest) {
    AdjListNode* newNode = (AdjListNode*)malloc(sizeof(AdjListNode));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

Graph* createGraph(int V) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->V = V;
    graph->array = (AdjList*)malloc(V * sizeof(AdjList));
    for (int i = 0; i < V; ++i) {
        graph->array[i].head = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int src, int dest) {
    AdjListNode* newNode = newAdjListNode(dest);
    newNode->next = graph->array[src].head;
    graph->array[src].head = newNode;

    newNode = newAdjListNode(src);
    newNode->next = graph->array[dest].head;
    graph->array[dest].head = newNode;
}

typedef struct QueueNode {
    int data;
    struct QueueNode* next;
} QueueNode;

typedef struct Queue {
    QueueNode *front, *rear;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    return q;
}

void enqueue(Queue* q, int data) {
    QueueNode* newNode = (QueueNode*)malloc(sizeof(QueueNode));
    newNode->data = data;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = q->rear = newNode;
        return;
    }
    q->rear->next = newNode;
    q->rear = newNode;
}

int dequeue(Queue* q) {
    if (q->front == NULL) return -1;
    QueueNode* temp = q->front;
    int data = temp->data;
    q->front = q->front->next;
    if (q->front == NULL) q->rear = NULL;
    free(temp);
    return data;
}

bool isQueueEmpty(Queue* q) {
    return q->front == NULL;
}

int collectCoins(int* coins, int coinsSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = coinsSize;
    if (n <= 1) {
        return 0;
    }

    Graph* graph = createGraph(n);
    int* degree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(graph, u, v);
        degree[u]++;
        degree[v]++;
    }

    int* temp_degree = (int*)malloc(n * sizeof(int));
    memcpy(temp_degree, degree, n * sizeof(int));

    Queue* q1 = createQueue();
    for (int i = 0; i < n; ++i) {
        if (temp_degree[i] == 1 && coins[i] == 0) {
            enqueue(q1, i);
        }
    }

    while (!isQueueEmpty(q1)) {
        int u = dequeue(q1);
        if (temp_degree[u] == 0) continue;

        temp_degree[u] = 0;

        AdjListNode* current = graph->array[u].head;
        while (current != NULL) {
            int v = current->dest;
            if (temp_degree[v] > 0) {
                temp_degree[v]--;
                if (temp_degree[v] == 1 && coins[v] == 0) {
                    enqueue(q1, v);
                }
            }
            current = current->next;
        }
    }
    free(q1);

    Queue* q2 = createQueue();
    for (int i = 0; i < n; ++i) {
        if (temp_degree[i] == 1) {
            enqueue(q2, i);
        }
    }

    while (!isQueueEmpty(q2)) {
        int u = dequeue(q2);
        if (temp_degree[u] == 0) continue;

        temp_degree[u] = 0;

        AdjListNode* current = graph->array[u].head;
        while (current != NULL) {
            int v = current->dest;
            if (temp_degree[v] > 0) {
                temp_degree[v]--;
            }
            current = current->next;
        }
    }
    free(q2);

    Queue* q3 = createQueue();
    for (int i = 0; i < n; ++i) {
        if (temp_degree[i] == 1) {
            enqueue(q3, i);
        }
    }

    while (!isQueueEmpty(q3)) {
        int u = dequeue(q3);
        if (temp_degree[u] == 0) continue;

        temp_degree[u] = 0;

        AdjListNode* current = graph->array[u].head;
        while (current != NULL) {
            int v = current->dest;
            if (temp_degree[v] > 0) {
                temp_degree[v]--;
            }
            current = current->next;
        }
    }
    free(q3);

    int remaining_edges = 0;
    for (int i = 0; i < n; ++i) {
        if (temp_degree[i] > 0) {
            AdjListNode* current = graph->array[i].head;
            while (current != NULL) {
                int v = current->dest;
                if (temp_degree[v] > 0) {
                    remaining_edges++;
                }
                current = current->next;
            }
        }
    }

    remaining_edges /= 2;

    int result = 2 * remaining_edges;

    free(degree);
    free(temp_degree);
    for (int i = 0; i < n; ++i) {
        AdjListNode* current = graph->array[i].head;
        while (current != NULL) {
            AdjListNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph->array);
    free(graph);

    return result;
}