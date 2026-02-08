typedef long long ll;

typedef struct {
    ll val;
    int idx;
    int side;
} Element;

typedef struct {
    Element* data;
    int size;
    int capacity;
} MinHeap;

void swap(Element* a, Element* b) {
    Element temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int idx) {
    if (idx == 0) return;
    int parent = (idx - 1) / 2;
    if (heap->data[parent].val > heap->data[idx].val || 
        (heap->data[parent].val == heap->data[idx].val && heap->data[parent].idx > heap->data[idx].idx)) {
        swap(&heap->data[parent], &heap->data[idx]);
        heapifyUp(heap, parent);
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;
    int smallest = idx;

    if (left < heap->size) {
        if (heap->data[left].val < heap->data[smallest].val ||
            (heap->data[left].val == heap->data[smallest].val && heap->data[left].idx < heap->data[smallest].idx)) {
            smallest = left;
        }
    }

    if (right < heap->size) {
        if (heap->data[right].val < heap->data[smallest].val ||
            (heap->data[right].val == heap->data[smallest].val && heap->data[right].idx < heap->data[smallest].idx)) {
            smallest = right;
        }
    }

    if (smallest != idx) {
        swap(&heap->data[idx], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void push(MinHeap* heap, ll val, int idx, int side) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = realloc(heap->data, heap->capacity * sizeof(Element));
    }
    heap->data[heap->size].val = val;
    heap->data[heap->size].idx = idx;
    heap->data[heap->size].side = side;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

Element pop(MinHeap* heap) {
    Element res = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return res;
}

long long totalCost(int* costs, int costsSize, int k, int candidates) {
    MinHeap heap;
    heap.data = malloc(2 * candidates * sizeof(Element));
    heap.size = 0;
    heap.capacity = 2 * candidates;

    int left = 0;
    int right = costsSize - 1;

    for (int i = 0; i < candidates && left <= right; i++) {
        push(&heap, costs[left], left, 0);
        left++;
        if (left <= right) {
            push(&heap, costs[right], right, 1);
            right--;
        }
    }

    ll total = 0;
    for (int i = 0; i < k; i++) {
        Element minElem = pop(&heap);
        total += minElem.val;

        if (left <= right) {
            if (minElem.side == 0) {
                push(&heap, costs[left], left, 0);
                left++;
            } else {
                push(&heap, costs[right], right, 1);
                right--;
            }
        }
    }

    free(heap.data);
    return total;
}