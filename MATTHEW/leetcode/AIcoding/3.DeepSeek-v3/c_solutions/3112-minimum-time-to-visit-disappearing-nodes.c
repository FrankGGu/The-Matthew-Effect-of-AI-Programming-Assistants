typedef struct {
    int node;
    int time;
} HeapNode;

typedef struct {
    HeapNode* data;
    int size;
    int capacity;
} MinHeap;

MinHeap* createHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (HeapNode*)malloc(capacity * sizeof(HeapNode));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->data[parent].time > heap->data[idx].time) {
            swap(&heap->data[parent], &heap->data[idx]);
            idx = parent;
        } else {
            break;
        }
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    while (2 * idx + 1 < heap->size) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int smallest = left;

        if (right < heap->size && heap->data[right].time < heap->data[left].time) {
            smallest = right;
        }

        if (heap->data[idx].time > heap->data[smallest].time) {
            swap(&heap->data[idx], &heap->data[smallest]);
            idx = smallest;
        } else {
            break;
        }
    }
}

void push(MinHeap* heap, int node, int time) {
    if (heap->size == heap->capacity) return;
    heap->data[heap->size].node = node;
    heap->data[heap->size].time = time;
    heapifyUp(heap, heap->size);
    heap->size++;
}

HeapNode pop(MinHeap* heap) {
    HeapNode res = heap->data[0];
    heap->size--;
    heap->data[0] = heap->data[heap->size];
    heapifyDown(heap, 0);
    return res;
}

int isEmpty(MinHeap* heap) {
    return heap->size == 0;
}

int* minimumTime(int n, int** edges, int edgesSize, int* edgesColSize, int* disappear, int disappearSize, int* returnSize) {
    int* dist = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }

    MinHeap* heap = createHeap(n * 10);
    push(heap, 0, 0);

    while (!isEmpty(heap)) {
        HeapNode curr = pop(heap);
        int u = curr.node;
        int time = curr.time;

        if (dist[u] != -1 && time >= dist[u]) continue;
        dist[u] = time;

        for (int i = 0; i < edgesSize; i++) {
            int v = -1;
            if (edges[i][0] == u) v = edges[i][1];
            else if (edges[i][1] == u) v = edges[i][0];

            if (v != -1) {
                int newTime = time + edges[i][2];
                if (newTime < disappear[v] && (dist[v] == -1 || newTime < dist[v])) {
                    push(heap, v, newTime);
                }
            }
        }
    }

    *returnSize = n;
    return dist;
}