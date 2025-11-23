#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int size;
    bool isPerfect;
    int height;
} Result;

int max(int a, int b) {
    return a > b ? a : b;
}

Result dfs(struct TreeNode* node, int* heap, int* heapSize, int k) {
    if (!node) {
        return (Result){0, true, 0};
    }

    Result left = dfs(node->left, heap, heapSize, k);
    Result right = dfs(node->right, heap, heapSize, k);

    int size = 1 + left.size + right.size;
    bool isPerfect = left.isPerfect && right.isPerfect && left.height == right.height;
    int height = 1 + max(left.height, right.height);

    if (isPerfect) {
        if (*heapSize < k) {
            heap[(*heapSize)++] = size;
            if (*heapSize == k) {
                for (int i = *heapSize / 2 - 1; i >= 0; i--) {
                    int parent = i;
                    int child = 2 * parent + 1;
                    while (child < *heapSize) {
                        if (child + 1 < *heapSize && heap[child] > heap[child + 1]) {
                            child++;
                        }
                        if (heap[parent] <= heap[child]) break;
                        int temp = heap[parent];
                        heap[parent] = heap[child];
                        heap[child] = temp;
                        parent = child;
                        child = 2 * parent + 1;
                    }
                }
            }
        } else if (size > heap[0]) {
            heap[0] = size;
            int i = 0;
            while (i < *heapSize) {
                int left = 2 * i + 1;
                int right = 2 * i + 2;
                int smallest = i;
                if (left < *heapSize && heap[left] < heap[smallest]) {
                    smallest = left;
                }
                if (right < *heapSize && heap[right] < heap[smallest]) {
                    smallest = right;
                }
                if (smallest != i) {
                    int temp = heap[i];
                    heap[i] = heap[smallest];
                    heap[smallest] = temp;
                    i = smallest;
                } else {
                    break;
                }
            }
        }
    }

    return (Result){size, isPerfect, height};
}

int kthLargestPerfectSubtree(struct TreeNode* root, int k) {
    int* heap = (int*)malloc(k * sizeof(int));
    int heapSize = 0;

    dfs(root, heap, &heapSize, k);

    int result = (heapSize < k) ? -1 : heap[0];
    free(heap);
    return result;
}