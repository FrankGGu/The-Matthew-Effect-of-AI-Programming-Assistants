typedef struct {
    int* arr;
    int size;
} MinHeap;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap* heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->arr[left] < heap->arr[smallest]) {
        smallest = left;
    }
    if (right < heap->size && heap->arr[right] < heap->arr[smallest]) {
        smallest = right;
    }
    if (smallest != idx) {
        swap(&heap->arr[idx], &heap->arr[smallest]);
        minHeapify(heap, smallest);
    }
}

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->arr = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    return heap;
}

void insertMinHeap(MinHeap* heap, int val) {
    heap->arr[heap->size] = val;
    int i = heap->size;
    heap->size++;

    while (i != 0 && heap->arr[(i - 1) / 2] > heap->arr[i]) {
        swap(&heap->arr[i], &heap->arr[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int removeMin(MinHeap* heap) {
    if (heap->size <= 0) return -1;
    if (heap->size == 1) {
        heap->size--;
        return heap->arr[0];
    }

    int root = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    minHeapify(heap, 0);
    return root;
}

int rangeSum(int* nums1, int nums1Size, int* nums2, int nums2Size, int left, int right) {
    MinHeap* heap = createMinHeap(nums1Size + nums2Size);
    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            insertMinHeap(heap, nums1[i] + nums2[j]);
        }
    }

    int sum = 0;
    for (int i = 0; i < right; i++) {
        int val = removeMin(heap);
        if (i >= left - 1) {
            sum += val;
        }
    }

    free(heap->arr);
    free(heap);
    return sum;
}