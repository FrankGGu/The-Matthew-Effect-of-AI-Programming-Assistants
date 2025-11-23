#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct AdjNode {
    int dest;
    struct AdjNode* next;
} AdjNode;

typedef struct Graph {
    int numNodes;
    AdjNode** adj;
} Graph;

AdjNode* createAdjNode(int dest) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

Graph* createGraph(int numNodes) {
    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->numNodes = numNodes;
    graph->adj = (AdjNode**)malloc(numNodes * sizeof(AdjNode*));
    for (int i = 0; i < numNodes; i++) {
        graph->adj[i] = NULL;
    }
    return graph;
}

void addEdge(Graph* graph, int src, int dest) {
    AdjNode* newNode = createAdjNode(dest);
    newNode->next = graph->adj[src];
    graph->adj[src] = newNode;

    newNode = createAdjNode(src);
    newNode->next = graph->adj[dest];
    graph->adj[dest] = newNode;
}

typedef struct QueueNode {
    int node;
    int time;
} QueueNode;

typedef struct Queue {
    QueueNode* array;
    int front, rear, size;
    unsigned capacity;
} Queue;

Queue* createQueue(unsigned capacity) {
    Queue* queue = (Queue*)malloc(sizeof(Queue));
    queue->capacity = capacity;
    queue->front = queue->size = 0;
    queue->rear = capacity - 1;
    queue->array = (QueueNode*)malloc(queue->capacity * sizeof(QueueNode));
    return queue;
}

int isQueueEmpty(Queue* queue) {
    return (queue->size == 0);
}

void enqueue(Queue* queue, int node, int time) {
    if (queue->size == queue->capacity) return;
    queue->rear = (queue->rear + 1) % queue->capacity;
    queue->array[queue->rear].node = node;
    queue->array[queue->rear].time = time;
    queue->size = queue->size + 1;
}

QueueNode dequeue(Queue* queue) {
    QueueNode item = {-1, -1};
    if (isQueueEmpty(queue)) return item;
    item = queue->array[queue->front];
    queue->front = (queue->front + 1) % queue->capacity;
    queue->size = queue->size - 1;
    return item;
}

int* timeTakenToMarkAllNodes(int n, int** edges, int edgesSize, int* edgesColSize, int* disappearedNodes, int disappearedNodesSize, int startNode, int* returnSize) {
    Graph* graph = createGraph(n);
    for (int i = 0; i < edgesSize; i++) {
        addEdge(graph, edges[i][0], edges[i][1]);
    }

    int* ans = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        ans[i] = -1;
    }

    Queue* q = createQueue(n);

    if (disappearedNodes[startNode] == -1 || 0 < disappearedNodes[startNode]) {
        ans[startNode] = 0;
        enqueue(q, startNode, 0);
    }

    while (!isQueueEmpty(q)) {
        QueueNode current = dequeue(q);
        int u = current.node;
        int time_u = current.time;

        AdjNode* temp = graph->adj[u];
        while (temp != NULL) {
            int v = temp->dest;
            int time_v = time_u + 1;

            if (disappearedNodes[v] != -1 && time_v >= disappearedNodes[v]) {
                temp = temp->next;
                continue;
            }

            if (ans[v] == -1 || time_v < ans[v]) {
                ans[v] = time_v;
                enqueue(q, v, time_v);
            }
            temp = temp->next;
        }
    }

    *returnSize = n;

    for (int i = 0; i < n; i++) {
        AdjNode* current = graph->adj[i];
        while (current != NULL) {
            AdjNode* next = current->next;
            free(current);
            current = next;
        }
    }
    free(graph->adj);
    free(graph);

    free(q->array);
    free(q);

    return ans;
}