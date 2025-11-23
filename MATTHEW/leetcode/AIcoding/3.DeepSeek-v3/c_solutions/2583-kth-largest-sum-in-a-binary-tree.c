#include <stdlib.h>
#include <limits.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    long long* arr;
    int size;
    int capacity;
} MinHeap;

MinHeap* createHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->arr = (long long*)malloc(sizeof(long long) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(long long* a, long long* b) {
    long long temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap->arr[idx] < heap->arr[parent]) {
        swap(&heap->arr[idx], &heap->arr[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int idx) {
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;
    int smallest = idx;

    if (left < heap->size && heap->arr[left] < heap->arr[smallest]) {
        smallest = left;
    }
    if (right < heap->size && heap->arr[right] < heap->arr[smallest]) {
        smallest = right;
    }
    if (smallest != idx) {
        swap(&heap->arr[idx], &heap->arr[smallest]);
        heapifyDown(heap, smallest);
    }
}

void push(MinHeap* heap, long long val) {
    if (heap->size < heap->capacity) {
        heap->arr[heap->size] = val;
        heapifyUp(heap, heap->size);
        heap->size++;
    } else if (val > heap->arr[0]) {
        heap->arr[0] = val;
        heapifyDown(heap, 0);
    }
}

long long kthLargestLevelSum(struct TreeNode* root, int k) {
    if (!root) return -1;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 100000);
    int front = 0, rear = 0;
    queue[rear++] = root;

    MinHeap* heap = createHeap(k);

    while (front < rear) {
        int levelSize = rear - front;
        long long levelSum = 0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front++];
            levelSum += node->val;

            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }

        push(heap, levelSum);
    }

    free(queue);

    if (heap->size < k) {
        free(heap->arr);
        free(heap);
        return -1;
    }

    long long result = heap->arr[0];
    free(heap->arr);
    free(heap);
    return result;
}