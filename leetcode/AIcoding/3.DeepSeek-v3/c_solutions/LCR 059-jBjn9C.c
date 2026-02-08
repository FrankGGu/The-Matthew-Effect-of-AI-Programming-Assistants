typedef struct {
    int* heap;
    int size;
    int capacity;
    int k;
} KthLargest;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(int* heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap[parent] <= heap[index]) break;
        swap(&heap[parent], &heap[index]);
        index = parent;
    }
}

void heapifyDown(int* heap, int size, int index) {
    while (index * 2 + 1 < size) {
        int left = index * 2 + 1;
        int right = index * 2 + 2;
        int smallest = left;

        if (right < size && heap[right] < heap[left]) {
            smallest = right;
        }

        if (heap[index] <= heap[smallest]) break;

        swap(&heap[index], &heap[smallest]);
        index = smallest;
    }
}

KthLargest* kthLargestCreate(int k, int* nums, int numsSize) {
    KthLargest* obj = (KthLargest*)malloc(sizeof(KthLargest));
    obj->k = k;
    obj->capacity = k + 1;
    obj->heap = (int*)malloc(obj->capacity * sizeof(int));
    obj->size = 0;

    for (int i = 0; i < numsSize; i++) {
        kthLargestAdd(obj, nums[i]);
    }

    return obj;
}

int kthLargestAdd(KthLargest* obj, int val) {
    if (obj->size < obj->k) {
        obj->heap[obj->size] = val;
        heapifyUp(obj->heap, obj->size);
        obj->size++;
    } else if (val > obj->heap[0]) {
        obj->heap[0] = val;
        heapifyDown(obj->heap, obj->size, 0);
    }

    return obj->heap[0];
}

void kthLargestFree(KthLargest* obj) {
    free(obj->heap);
    free(obj);
}