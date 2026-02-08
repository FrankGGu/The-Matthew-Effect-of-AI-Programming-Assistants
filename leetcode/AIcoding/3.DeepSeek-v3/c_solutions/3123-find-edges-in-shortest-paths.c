typedef struct {
    int node;
    int weight;
} Edge;

typedef struct {
    Edge* edges;
    int size;
    int capacity;
} AdjList;

typedef struct {
    int node;
    long long dist;
} HeapNode;

typedef struct {
    HeapNode* heap;
    int size;
    int capacity;
} MinHeap;

void initAdjList(AdjList* list) {
    list->capacity = 10;
    list->edges = (Edge*)malloc(list->capacity * sizeof(Edge));
    list->size = 0;
}

void addEdge(AdjList* list, int node, int weight) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->edges = (Edge*)realloc(list->edges, list->capacity * sizeof(Edge));
    }
    list->edges[list->size].node = node;
    list->edges[list->size].weight = weight;
    list->size++;
}

void initMinHeap(MinHeap* h, int capacity) {
    h->heap = (HeapNode*)malloc(capacity * sizeof(HeapNode));
    h->size = 0;
    h->capacity = capacity;
}

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* h, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (h->heap[parent].dist > h->heap[idx].dist) {
            swap(&h->heap[parent], &h->heap[idx]);
            idx = parent;
        } else {
            break;
        }
    }
}

void heapifyDown(MinHeap* h, int idx) {
    while (2 * idx + 1 < h->size) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int smallest = idx;

        if (left < h->size && h->heap[left].dist < h->heap[smallest].dist) {
            smallest = left;
        }
        if (right < h->size && h->heap[right].dist < h->heap[smallest].dist) {
            smallest = right;
        }
        if (smallest != idx) {
            swap(&h->heap[idx], &h->heap[smallest]);
            idx = smallest;
        } else {
            break;
        }
    }
}

void push(MinHeap* h, int node, long long dist) {
    if (h->size == h->capacity) return;
    h->heap[h->size].node = node;
    h->heap[h->size].dist = dist;
    h->size++;
    heapifyUp(h, h->size - 1);
}

HeapNode pop(MinHeap* h) {
    HeapNode res = h->heap[0];
    h->heap[0] = h->heap[h->size - 1];
    h->size--;
    heapifyDown(h, 0);
    return res;
}

void dijkstra(int n, AdjList* graph, int start, long long* dist) {
    for (int i = 0; i < n; i++) {
        dist[i] = LLONG_MAX;
    }
    dist[start] = 0;

    MinHeap heap;
    initMinHeap(&heap, n);
    push(&heap, start, 0);

    while (heap.size > 0) {
        HeapNode current = pop(&heap);
        int u = current.node;
        long long d = current.dist;

        if (d > dist[u]) continue;

        for (int i = 0; i < graph[u].size; i++) {
            int v = graph[u].edges[i].node;
            int w = graph[u].edges[i].weight;
            long long newDist = d + w;
            if (newDist < dist[v]) {
                dist[v] = newDist;
                push(&heap, v, newDist);
            }
        }
    }
    free(heap.heap);
}

bool* findAnswer(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    AdjList* graph = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        initAdjList(&graph[i]);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];
        addEdge(&graph[u], v, w);
        addEdge(&graph[v], u, w);
    }

    long long* distFrom0 = (long long*)malloc(n * sizeof(long long));
    long long* distFromN = (long long*)malloc(n * sizeof(long long));

    dijkstra(n, graph, 0, distFrom0);
    dijkstra(n, graph, n - 1, distFromN);

    long long shortest = distFrom0[n - 1];

    bool* answer = (bool*)malloc(edgesSize * sizeof(bool));
    *returnSize = edgesSize;
    for (int i = 0; i < edgesSize; i++) {
        answer[i] = false;
    }

    if (shortest == LLONG_MAX) {
        for (int i = 0; i < n; i++) {
            free(graph[i].edges);
        }
        free(graph);
        free(distFrom0);
        free(distFromN);
        return answer;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        int w = edges[i][2];

        if (distFrom0[u] + w + distFromN[v] == shortest || 
            distFrom0[v] + w + distFromN[u] == shortest) {
            answer[i] = true;
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i].edges);
    }
    free(graph);
    free(distFrom0);
    free(distFromN);

    return answer;
}