#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int row;
    int col;
} Node;

typedef struct {
    Node* heap;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->heap = (Node*)malloc(capacity * sizeof(Node));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    return minHeap;
}

void swap(Node* a, Node* b) {
    Node temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap* minHeap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < minHeap->size && minHeap->heap[left].val < minHeap->heap[smallest].val)
        smallest = left;

    if (right < minHeap->size && minHeap->heap[right].val < minHeap->heap[smallest].val)
        smallest = right;

    if (smallest != idx) {
        swap(&minHeap->heap[idx], &minHeap->heap[smallest]);
        minHeapify(minHeap, smallest);
    }
}

void insert(MinHeap* minHeap, Node node) {
    int i = minHeap->size;
    minHeap->size++;

    while (i > 0 && node.val < minHeap->heap[(i - 1) / 2].val) {
        minHeap->heap[i] = minHeap->heap[(i - 1) / 2];
        i = (i - 1) / 2;
    }

    minHeap->heap[i] = node;
}

Node extractMin(MinHeap* minHeap) {
    Node root = minHeap->heap[0];
    minHeap->heap[0] = minHeap->heap[minHeap->size - 1];
    minHeap->size--;
    minHeapify(minHeap, 0);
    return root;
}

int* smallestRange(int** nums, int numsSize, int* numsColSize, int* returnSize) {
    int minRange = INT_MAX;
    int start = -1, end = -1;
    int maxVal = INT_MIN;

    MinHeap* minHeap = createMinHeap(numsSize);

    for (int i = 0; i < numsSize; i++) {
        Node node;
        node.val = nums[i][0];
        node.row = i;
        node.col = 0;
        insert(minHeap, node);
        if (node.val > maxVal) {
            maxVal = node.val;
        }
    }

    while (1) {
        Node root = extractMin(minHeap);
        int minVal = root.val;

        if (maxVal - minVal < minRange) {
            minRange = maxVal - minVal;
            start = minVal;
            end = maxVal;
        }

        if (root.col + 1 < numsColSize[root.row]) {
            Node newNode;
            newNode.val = nums[root.row][root.col + 1];
            newNode.row = root.row;
            newNode.col = root.col + 1;
            insert(minHeap, newNode);

            if (newNode.val > maxVal) {
                maxVal = newNode.val;
            }
        } else {
            break;
        }
    }

    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = start;
    result[1] = end;

    free(minHeap->heap);
    free(minHeap);

    return result;
}