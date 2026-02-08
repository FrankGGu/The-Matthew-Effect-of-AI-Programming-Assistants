#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int *data;
    int size;
    int capacity;
} Heap;

Heap* createHeap(int capacity) {
    Heap* heap = (Heap*)malloc(sizeof(Heap));
    heap->data = (int*)malloc(capacity * sizeof(int));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapifyUp(Heap* heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap->data[index] < heap->data[parent]) {
            swap(&heap->data[index], &heap->data[parent]);
            index = parent;
        } else {
            break;
        }
    }
}

void heapifyDown(Heap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left] < heap->data[smallest]) {
        smallest = left;
    }

    if (right < heap->size && heap->data[right] < heap->data[smallest]) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void push(Heap* heap, int value) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = (int*)realloc(heap->data, heap->capacity * sizeof(int));
    }
    heap->data[heap->size++] = value;
    heapifyUp(heap, heap->size - 1);
}

int pop(Heap* heap) {
    if (heap->size == 0) {
        return -1;
    }
    int root = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    heapifyDown(heap, 0);
    return root;
}

int kthLargestSum(struct TreeNode* root, int k) {
    if (!root) return -1;

    int capacity = 1000;
    Heap* heap = createHeap(capacity);

    int levelSize = 1;
    int sum = 0;
    int count = 0;

    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    queue[0] = root;
    int front = 0;
    int rear = 1;

    while (front < rear) {
        sum = 0;
        levelSize = rear - front;
        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = queue[front + i];
            sum += node->val;
            if (node->left) {
                queue = (struct TreeNode**)realloc(queue, rear + 1 * sizeof(struct TreeNode*));
                queue[rear++] = node->left;
            }
            if (node->right) {
                queue = (struct TreeNode**)realloc(queue, rear + 1 * sizeof(struct TreeNode*));
                queue[rear++] = node->right;
            }
        }
        push(heap, sum);
        count++;
    }

    while (k > 1) {
        pop(heap);
        k--;
    }

    int result = pop(heap);
    free(heap->data);
    free(heap);
    free(queue);
    return result;
}