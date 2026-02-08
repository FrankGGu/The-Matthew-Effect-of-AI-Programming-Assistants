#include <limits.h>
#include <stdlib.h>

typedef struct Edge {
    int to;
    int weight;
    struct Edge* next;
} Edge;

typedef struct Node {
    Edge* head;
} Node;

typedef struct PQItem {
    int node;
    int dist;
} PQItem;

typedef struct PriorityQueue {
    PQItem* heap;
    int capacity;
    int size;
} PriorityQueue;

PriorityQueue* createPriorityQueue(int capacity) {
    PriorityQueue* pq = (PriorityQueue*)malloc(sizeof(PriorityQueue));
    pq->heap = (PQItem*)malloc(sizeof(PQItem) * (capacity + 1));
    pq->capacity = capacity;
    pq->size = 0;
    return pq;
}

void swap(PQItem* a, PQItem* b) {
    PQItem temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(PriorityQueue* pq, int index) {
    while (index > 1 && pq->heap[index].dist < pq->heap[index / 2].dist) {
        swap(&pq->heap[index], &pq->heap[index / 2]);
        index /= 2;
    }
}

void heapifyDown(PriorityQueue* pq, int index) {
    int smallest = index;
    int left = 2 * index;
    int right = 2 * index + 1;

    if (left <= pq->size && pq->heap[left].dist < pq->heap[smallest].dist) {
        smallest = left;
    }
    if (right <= pq->size && pq->heap[right].dist < pq->heap[smallest].dist) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&pq->heap[index], &pq->heap[smallest]);
        heapifyDown(pq, smallest);
    }
}

void push(PriorityQueue* pq, int node, int dist) {
    if (pq->size >= pq->capacity) {
        return;
    }
    pq->size++;
    pq->heap[pq->size] = (PQItem){node, dist};
    heapifyUp(pq, pq->size);
}

PQItem pop(PriorityQueue* pq) {
    if (pq->size == 0) {
        return (PQItem){-1, -1};
    }
    PQItem item = pq->heap[1];
    pq->heap[1] = pq->heap[pq->size];
    pq->size--;
    heapifyDown(pq, 1);
    return item;
}

int isEmpty(PriorityQueue* pq) {
    return pq->size == 0;
}

void destroyPriorityQueue(PriorityQueue* pq) {
    free(pq->heap);
    free(pq);
}

void addEdge(Node* graph, int u, int v, int weight) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = v;
    newEdge->weight = weight;
    newEdge->next = graph[u].head;
    graph[u].head = newEdge;
}

int shortestPathDijkstra(int n, int** edges, int edgesSize, int* edgesColSize, int source, int destination) {
    Node* graph = (Node*)calloc(n, sizeof(Node));
    if (!graph) return -1;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int weight = edges[i][2];
        addEdge(graph, u, v, weight);
    }

    int* dist = (int*)malloc(sizeof(int) * n);
    if (!dist) {
        for (int i = 0; i < n; i++) {
            Edge* current = graph[i].head;
            while (current) {
                Edge* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(graph);
        return -1;
    }

    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[source] = 0;

    PriorityQueue* pq = createPriorityQueue(n * n);
    if (!pq) {
        free(dist);
        for (int i = 0; i < n; i++) {
            Edge* current = graph[i].head;
            while (current) {
                Edge* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(graph);
        return -1;
    }
    push(pq, source, 0);

    while (!isEmpty(pq)) {
        PQItem current = pop(pq);
        int u = current.node;
        int d = current.dist;

        if (d > dist[u]) {
            continue;
        }

        if (u == destination) {
            int result = dist[destination];

            destroyPriorityQueue(pq);
            free(dist);
            for (int i = 0; i < n; i++) {
                Edge* currentEdge = graph[i].head;
                while (currentEdge) {
                    Edge* temp = currentEdge;
                    currentEdge = currentEdge->next;
                    free(temp);
                }
            }
            free(graph);
            return result;
        }

        Edge* edge = graph[u].head;
        while (edge) {
            int v = edge->to;
            int weight = edge->weight;
            if (dist[u] != INT_MAX && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                push(pq, v, dist[v]);
            }
            edge = edge->next;
        }
    }

    int result = (dist[destination] == INT_MAX) ? -1 : dist[destination];

    destroyPriorityQueue(pq);
    free(dist);
    for (int i = 0; i < n; i++) {
        Edge* current = graph[i].head;
        while (current) {
            Edge* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(graph);

    return result;
}