#include <stdlib.h>
#include <limits.h> // For LLONG_MAX

typedef struct {
    long long time;
    int node;
} PQNode;

typedef struct {
    PQNode* data;
    int size;
    int capacity;
} MinHeap;

static void swap(PQNode* a, PQNode* b) {
    PQNode temp = *a;
    *a = *b;
    *b = temp;
}

static void heapifyUp(MinHeap* heap, int idx) {
    while (idx > 0 && heap->data[idx].time < heap->data[(idx - 1) / 2].time) {
        swap(&heap->data[idx], &heap->data[(idx - 1) / 2]);
        idx = (idx - 1) / 2;
    }
}

static void heapifyDown(MinHeap* heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->data[left].time < heap->data[smallest].time) {
        smallest = left;
    }
    if (right < heap->size && heap->data[right].time < heap->data[smallest].time) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap->data[idx], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

static MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (PQNode*)malloc(sizeof(PQNode) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

static void destroyMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

static void pushMinHeap(MinHeap* heap, long long time, int node) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (PQNode*)realloc(heap->data, sizeof(PQNode) * heap->capacity);
    }
    heap->data[heap->size].time = time;
    heap->data[heap->size].node = node;
    heapifyUp(heap, heap->size);
    heap->size++;
}

static PQNode popMinHeap(MinHeap* heap) {
    PQNode root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

static int isEmptyMinHeap(MinHeap* heap) {
    return heap->size == 0;
}

typedef struct AdjNode {
    int to;
    int weight;
    struct AdjNode* next;
} AdjNode;

int* minimumTime(int n, int** edges, int edgesSize, int* edgesColSize, int* disappearingTimes, int* returnSize) {
    AdjNode** adj = (AdjNode**)calloc(n, sizeof(AdjNode*));
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        AdjNode* newNode1 = (AdjNode*)malloc(sizeof(AdjNode));
        newNode1->to = v;
        newNode1->weight = w;
        newNode1->next = adj[u];
        adj[u] = newNode1;

        AdjNode* newNode2 = (AdjNode*)malloc(sizeof(AdjNode));
        newNode2->to = u;
        newNode2->weight = w;
        newNode2->next = adj[v];
        adj[v] = newNode2;
    }

    long long* dist = (long long*)malloc(sizeof(long long) * n);
    for (int i = 0; i < n; i++) {
        dist[i] = LLONG_MAX;
    }
    dist[0] = 0;

    MinHeap* pq = createMinHeap(edgesSize * 2 + 1);
    pushMinHeap(pq, 0LL, 0);

    while (!isEmptyMinHeap(pq)) {
        PQNode current = popMinHeap(pq);
        long long d = current.time;
        int u = current.node;

        if (d > dist[u]) {
            continue;
        }

        if (d >= disappearingTimes[u]) {
            continue;
        }

        AdjNode* neighbor = adj[u];
        while (neighbor != NULL) {
            int v = neighbor->to;
            int weight = neighbor->weight;

            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pushMinHeap(pq, dist[v], v);
            }
            neighbor = neighbor->next;
        }
    }

    int* result = (int*)malloc(sizeof(int) * n);
    *returnSize = n;
    for (int i = 0; i < n; i++) {
        if (dist[i] == LLONG_MAX) {
            result[i] = -1;
        } else {
            result[i] = (int)dist[i];
        }
    }

    destroyMinHeap(pq);
    free(dist);
    for (int i = 0; i < n; i++) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);

    return result;
}