#include <stdlib.h>
#include <string.h>

typedef struct AdjNode {
    int dest;
    struct AdjNode* next;
} AdjNode;

typedef struct {
    AdjNode** heads;
    int numNodes;
} Graph;

AdjNode* createAdjNode(int dest) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

void addEdge(Graph* graph, int src, int dest) {
    AdjNode* newNode = createAdjNode(dest);
    newNode->next = graph->heads[src];
    graph->heads[src] = newNode;
}

void freeGraph(Graph* graph) {
    if (!graph) return;
    for (int i = 0; i < graph->numNodes; i++) {
        AdjNode* current = graph->heads[i];
        while (current) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph->heads);
    free(graph);
}

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
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = item;
    q->size++;
}

int dequeue(Queue* q) {
    if (q->size == 0) return -1;
    int item = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return item;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    if (!q) return;
    free(q->data);
    free(q);
}

int maximumProfit(int n, int** edges, int edgesSize, int* edgesColSize, int* profits, int profitsSize) {
    if (n == 0) {
        return 0;
    }

    Graph* graph = (Graph*)malloc(sizeof(Graph));
    graph->numNodes = n;
    graph->heads = (AdjNode**)calloc(n, sizeof(AdjNode*));

    int* inDegree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(graph, u, v);
        inDegree[v]++;
    }

    long long* dp = (long long*)malloc(sizeof(long long) * n);
    for (int i = 0; i < n; i++) {
        dp[i] = profits[i];
    }

    Queue* q = createQueue(n);
    for (int i = 0; i < n; i++) {
        if (inDegree[i] == 0) {
            enqueue(q, i);
        }
    }

    while (!isEmpty(q)) {
        int u = dequeue(q);

        AdjNode* current = graph->heads[u];
        while (current) {
            int v = current->dest;

            if (dp[u] + profits[v] > dp[v]) {
                dp[v] = dp[u] + profits[v];
            }

            inDegree[v]--;
            if (inDegree[v] == 0) {
                enqueue(q, v);
            }
            current = current->next;
        }
    }

    long long max_profit = dp[0]; 
    for (int i = 1; i < n; i++) {
        if (dp[i] > max_profit) {
            max_profit = dp[i];
        }
    }

    freeGraph(graph);
    free(inDegree);
    free(dp);
    freeQueue(q);

    return (int)max_profit;
}