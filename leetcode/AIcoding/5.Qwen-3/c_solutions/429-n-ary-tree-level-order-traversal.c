#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int val;
    int numChildren;
    struct Node** children;
} Node;

typedef struct {
    int* data;
    int size;
    int capacity;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = NULL;
    q->size = 0;
    q->capacity = 0;
    return q;
}

void enqueue(Queue* q, Node* node) {
    if (q->size == q->capacity) {
        q->capacity = q->capacity ? q->capacity * 2 : 1;
        q->data = (int*)realloc(q->data, q->capacity * sizeof(int));
    }
    q->data[q->size++] = (int)(long)node;
}

Node* dequeue(Queue* q) {
    if (q->size == 0) return NULL;
    Node* node = (Node*)(long)q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
    q->size--;
    return node;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int** levelOrder(struct Node* root, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (!root) return NULL;

    int** result = NULL;
    *returnColumnSizes = NULL;

    Queue* q = createQueue();
    enqueue(q, root);

    while (!isEmpty(q)) {
        int levelSize = q->size;
        int* levelData = (int*)malloc(levelSize * sizeof(int));
        int levelIndex = 0;

        for (int i = 0; i < levelSize; i++) {
            Node* node = dequeue(q);
            levelData[levelIndex++] = node->val;
            for (int j = 0; j < node->numChildren; j++) {
                enqueue(q, node->children[j]);
            }
        }

        result = (int**)realloc(result, (*returnSize + 1) * sizeof(int*));
        result[*returnSize] = levelData;
        *returnColumnSizes = (int*)realloc(*returnColumnSizes, (*returnSize + 1) * sizeof(int));
        (*returnColumnSizes)[*returnSize] = levelSize;
        (*returnSize)++;
    }

    freeQueue(q);
    return result;
}