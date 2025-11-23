typedef long long ll;

typedef struct {
    ll* data;
    int size;
    int capacity;
} MinHeap;

void swap(ll* a, ll* b) {
    ll temp = *a;
    *a = *b;
    *b = temp;
}

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (ll*)malloc(capacity * sizeof(ll));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void heapifyUp(MinHeap* heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->data[parent] <= heap->data[idx]) break;
        swap(&heap->data[parent], &heap->data[idx]);
        idx = parent;
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    while (1) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int smallest = idx;

        if (left < heap->size && heap->data[left] < heap->data[smallest]) {
            smallest = left;
        }
        if (right < heap->size && heap->data[right] < heap->data[smallest]) {
            smallest = right;
        }
        if (smallest == idx) break;

        swap(&heap->data[idx], &heap->data[smallest]);
        idx = smallest;
    }
}

void push(MinHeap* heap, ll value) {
    if (heap->size == heap->capacity) return;
    heap->data[heap->size] = value;
    heapifyUp(heap, heap->size);
    heap->size++;
}

ll pop(MinHeap* heap) {
    if (heap->size == 0) return -1;
    ll minVal = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return minVal;
}

ll top(MinHeap* heap) {
    if (heap->size == 0) return -1;
    return heap->data[0];
}

int minOperations(int* nums, int numsSize, int k) {
    MinHeap* heap = createMinHeap(numsSize);
    for (int i = 0; i < numsSize; i++) {
        push(heap, nums[i]);
    }

    int operations = 0;
    while (heap->size > 1 && top(heap) < k) {
        ll x = pop(heap);
        ll y = pop(heap);
        ll newVal = x * 2 + y;
        push(heap, newVal);
        operations++;
    }

    free(heap->data);
    free(heap);

    return operations;
}