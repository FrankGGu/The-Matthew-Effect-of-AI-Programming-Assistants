#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

typedef struct Edge {
    int to_city;
    int distance;
    struct Edge* next;
} Edge;

typedef struct CityNode {
    Edge* head;
} CityNode;

typedef struct QueueNode {
    int city_id;
    struct QueueNode* next;
} QueueNode;

typedef struct {
    QueueNode* front;
    QueueNode* rear;
} Queue;

void enqueue(Queue* q, int city_id) {
    QueueNode* newNode = (QueueNode*)malloc(sizeof(QueueNode));
    newNode->city_id = city_id;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = newNode;
        q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
}

int dequeue(Queue* q) {
    if (q->front == NULL) return -1;
    QueueNode* temp = q->front;
    int city_id = temp->city_id;
    q->front = q->front->next;
    if (q->front == NULL) {
        q->rear = NULL;
    }
    free(temp);
    return city_id;
}

bool is_empty(Queue* q) {
    return q->front == NULL;
}

int minScore(int n, int** roads, int roadsSize, int* roadsColSize) {
    CityNode* adj = (CityNode*)malloc((n + 1) * sizeof(CityNode));
    for (int i = 0; i <= n; ++i) {
        adj[i].head = NULL;
    }

    for (int i = 0; i < roadsSize; ++i) {
        int u = roads[i][0];
        int v = roads[i][1];
        int d = roads[i][2];

        Edge* edge_uv = (Edge*)malloc(sizeof(Edge));
        edge_uv->to_city = v;
        edge_uv->distance = d;
        edge_uv->next = adj[u].head;
        adj[u].head = edge_uv;

        Edge* edge_vu = (Edge*)malloc(sizeof(Edge));
        edge_vu->to_city = u;
        edge_vu->distance = d;
        edge_vu->next = adj[v].head;
        adj[v].head = edge_vu;
    }

    bool* visited = (bool*)calloc(n + 1, sizeof(bool));
    Queue q = {NULL, NULL};
    int min_overall_distance = INT_MAX;

    enqueue(&q, 1);
    visited[1] = true;

    while (!is_empty(&q)) {
        int u = dequeue(&q);

        Edge* current_edge = adj[u].head;
        while (current_edge != NULL) {
            int v = current_edge->to_city;
            int d = current_edge->distance;

            if (d < min_overall_distance) {
                min_overall_distance = d;
            }

            if (!visited[v]) {
                visited[v] = true;
                enqueue(&q, v);
            }
            current_edge = current_edge->next;
        }
    }

    for (int i = 0; i <= n; ++i) {
        Edge* current = adj[i].head;
        while (current != NULL) {
            Edge* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);
    free(visited);

    return min_overall_distance;
}