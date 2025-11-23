#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int *data;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap *heap = (MinHeap *)malloc(sizeof(MinHeap));
    heap->data = (int *)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void minHeapInsert(MinHeap *heap, int val) {
    if (heap->size < heap->capacity) {
        heap->data[heap->size++] = val;
        int i = heap->size - 1;
        while (i > 0 && heap->data[i] < heap->data[(i - 1) / 2]) {
            int temp = heap->data[i];
            heap->data[i] = heap->data[(i - 1) / 2];
            heap->data[(i - 1) / 2] = temp;
            i = (i - 1) / 2;
        }
    } else if (val > heap->data[0]) {
        heap->data[0] = val;
        int i = 0;
        while (1) {
            int left = 2 * i + 1;
            int right = 2 * i + 2;
            int smallest = i;
            if (left < heap->size && heap->data[left] < heap->data[smallest]) smallest = left;
            if (right < heap->size && heap->data[right] < heap->data[smallest]) smallest = right;
            if (smallest != i) {
                int temp = heap->data[i];
                heap->data[i] = heap->data[smallest];
                heap->data[smallest] = temp;
                i = smallest;
            } else {
                break;
            }
        }
    }
}

void dfs(TreeNode *root, int *sum, int *size, int **sums) {
    if (!root) return;
    *sum += root->val;
    sums[(*size)++] = *sum;
    dfs(root->left, sum, size, sums);
    dfs(root->right, sum, size, sums);
    *sum -= root->val;
}

int kthLargestLevelSum(TreeNode* root, int k) {
    if (!root) return 0;
    int *sums[10000];
    int size = 0;
    int sum = 0;
    dfs(root, &sum, &size, sums);

    MinHeap *heap = createMinHeap(k);
    for (int i = 0; i < size; i++) {
        minHeapInsert(heap, sums[i]);
    }

    int result = heap->data[0];
    free(heap->data);
    free(heap);
    return result;
}