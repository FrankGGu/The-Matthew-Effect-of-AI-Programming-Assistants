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
    int dist;
} HeapNode;

typedef struct {
    HeapNode* heap;
    int size;
    int capacity;
} MinHeap;

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->heap = (HeapNode*)malloc(capacity * sizeof(HeapNode));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    return minHeap;
}

void heapifyUp(MinHeap* minHeap, int idx) {
    while (idx > 0 && minHeap->heap[(idx - 1) / 2].dist > minHeap->heap[idx].dist) {
        swap(&minHeap->heap[(idx - 1) / 2], &minHeap->heap[idx]);
        idx = (idx - 1) / 2;
    }
}

void heapifyDown(MinHeap* minHeap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < minHeap->size && minHeap->heap[left].dist < minHeap->heap[smallest].dist) {
        smallest = left;
    }

    if (right < minHeap->size && minHeap->heap[right].dist < minHeap->heap[smallest].dist) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&minHeap->heap[idx], &minHeap->heap[smallest]);
        heapifyDown(minHeap, smallest);
    }
}

void push(MinHeap* minHeap, int node, int dist) {
    if (minHeap->size == minHeap->capacity) return;

    minHeap->heap[minHeap->size].node = node;
    minHeap->heap[minHeap->size].dist = dist;
    heapifyUp(minHeap, minHeap->size);
    minHeap->size++;
}

HeapNode pop(MinHeap* minHeap) {
    HeapNode empty = {-1, -1};
    if (minHeap->size == 0) return empty;

    HeapNode root = minHeap->heap[0];
    minHeap->heap[0] = minHeap->heap[minHeap->size - 1];
    minHeap->size--;
    heapifyDown(minHeap, 0);
    return root;
}

int isEmpty(MinHeap* minHeap) {
    return minHeap->size == 0;
}

void dijkstra(int n, AdjList* graph, int* dist) {
    for (int i = 0; i < n; i++) {
        dist[i] = INT_MAX;
    }
    dist[n - 1] = 0;

    MinHeap* minHeap = createMinHeap(n);
    push(minHeap, n - 1, 0);

    while (!isEmpty(minHeap)) {
        HeapNode current = pop(minHeap);
        int u = current.node;

        if (current.dist != dist[u]) continue;

        for (int i = 0; i < graph[u].size; i++) {
            Edge edge = graph[u].edges[i];
            int v = edge.node;
            int weight = edge.weight;

            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                push(minHeap, v, dist[v]);
            }
        }
    }

    free(minHeap->heap);
    free(minHeap);
}

int dfs(int u, int n, AdjList* graph, int* dist, int* memo) {
    if (u == n - 1) return 1;
    if (memo[u] != -1) return memo[u];

    long long count = 0;
    for (int i = 0; i < graph[u].size; i++) {
        int v = graph[u].edges[i].node;
        if (dist[u] > dist[v]) {
            count = (count + dfs(v, n, graph, dist, memo)) % 1000000007;
        }
    }

    memo[u] = count;
    return count;
}

int compare(const void* a, const void* b) {
    int* arr1 = *(int**)a;
    int* arr2 = *(int**)b;
    return arr1[0] - arr2[0];
}

int countRestrictedPaths(int n, int** edges, int edgesSize, int* edgesColSize) {
    AdjList* graph = (AdjList*)malloc(n * sizeof(AdjList));
    for (int i = 0; i < n; i++) {
        graph[i].edges = (Edge*)malloc(10 * sizeof(Edge));
        graph[i].size = 0;
        graph[i].capacity = 10;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0] - 1;
        int v = edges[i][1] - 1;
        int weight = edges[i][2];

        if (graph[u].size == graph[u].capacity) {
            graph[u].capacity *= 2;
            graph[u].edges = (Edge*)realloc(graph[u].edges, graph[u].capacity * sizeof(Edge));
        }
        graph[u].edges[graph[u].size].node = v;
        graph[u].edges[graph[u].size].weight = weight;
        graph[u].size++;

        if (graph[v].size == graph[v].capacity) {
            graph[v].capacity *= 2;
            graph[v].edges = (Edge*)realloc(graph[v].edges, graph[v].capacity * sizeof(Edge));
        }
        graph[v].edges[graph[v].size].node = u;
        graph[v].edges[graph[v].size].weight = weight;
        graph[v].size++;
    }

    int* dist = (int*)malloc(n * sizeof(int));
    dijkstra(n, graph, dist);

    int* memo = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        memo[i] = -1;
    }

    int result = dfs(0, n, graph, dist, memo);

    for (int i = 0; i < n; i++) {
        free(graph[i].edges);
    }
    free(graph);
    free(dist);
    free(memo);

    return result;
}