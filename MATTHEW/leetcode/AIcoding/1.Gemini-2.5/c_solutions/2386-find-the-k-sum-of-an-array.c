#include <stdlib.h> // For malloc, free, qsort, abs

typedef struct {
    long long sum;
    int idx;
} HeapNode;

typedef struct {
    HeapNode* nodes;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->nodes = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void destroyMinHeap(MinHeap* heap) {
    free(heap->nodes);
    free(heap);
}

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->nodes[index].sum < heap->nodes[parent].sum) {
        swap(&heap->nodes[index], &heap->nodes[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int leftChild = 2 * index + 1;
    int rightChild = 2 * index + 2;
    int smallest = index;

    if (leftChild < heap->size && heap->nodes[leftChild].sum < heap->nodes[smallest].sum) {
        smallest = leftChild;
    }
    if (rightChild < heap->size && heap->nodes[rightChild].sum < heap->nodes[smallest].sum) {
        smallest = rightChild;
    }

    if (smallest != index) {
        swap(&heap->nodes[index], &heap->nodes[smallest]);
        heapifyDown(heap, smallest);
    }
}

void minHeapPush(MinHeap* heap, HeapNode node) {
    if (heap->size == heap->capacity) {
        return; 
    }
    heap->nodes[heap->size] = node;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

HeapNode minHeapPop(MinHeap* heap) {
    HeapNode root = heap->nodes[0];
    heap->nodes[0] = heap->nodes[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

int compareLongLong(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

long long* kSum(int* nums, int numsSize, int k, int* returnSize) {
    long long maxSum = 0;
    long long* diffs = (long long*)malloc(sizeof(long long) * numsSize);

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] >= 0) {
            maxSum += nums[i];
        }
        diffs[i] = (long long)abs(nums[i]);
    }

    qsort(diffs, numsSize, sizeof(long long), compareLongLong);

    long long* ans = (long long*)malloc(sizeof(long long) * k);
    *returnSize = k;

    ans[0] = maxSum;
    if (k == 1) {
        free(diffs);
        return ans;
    }

    MinHeap* pq = createMinHeap(2 * k); 

    minHeapPush(pq, (HeapNode){diffs[0], 0});

    for (int i = 1; i < k; ++i) {
        HeapNode top = minHeapPop(pq);
        ans[i] = maxSum - top.sum;

        if (top.idx + 1 < numsSize) {
            minHeapPush(pq, (HeapNode){top.sum + diffs[top.idx + 1], top.idx + 1});
            minHeapPush(pq, (HeapNode){top.sum - diffs[top.idx] + diffs[top.idx + 1], top.idx + 1});
        }
    }

    destroyMinHeap(pq);
    free(diffs);
    return ans;
}