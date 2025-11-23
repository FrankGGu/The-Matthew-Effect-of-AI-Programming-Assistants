#include <stdlib.h>

struct Node {
    int val;
    struct Node **children;
    int childrenSize;
};

struct Queue {
    struct Node **nodes;
    int front;
    int rear;
    int size;
};

struct Queue* createQueue(int capacity) {
    struct Queue *queue = (struct Queue *)malloc(sizeof(struct Queue));
    queue->nodes = (struct Node **)malloc(capacity * sizeof(struct Node *));
    queue->front = 0;
    queue->rear = -1;
    queue->size = 0;
    return queue;
}

int isEmpty(struct Queue *queue) {
    return queue->size == 0;
}

void enqueue(struct Queue *queue, struct Node *node) {
    queue->rear = (queue->rear + 1) % (queue->size + 1);
    queue->nodes[queue->rear] = node;
    queue->size++;
}

struct Node* dequeue(struct Queue *queue) {
    struct Node *node = queue->nodes[queue->front];
    queue->front = (queue->front + 1) % (queue->size + 1);
    queue->size--;
    return node;
}

void freeQueue(struct Queue *queue) {
    free(queue->nodes);
    free(queue);
}

int** levelOrder(struct Node* root, int* returnSize, int** returnColumnSizes) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int capacity = 100;
    int **result = (int **)malloc(capacity * sizeof(int *));
    *returnColumnSizes = (int *)malloc(capacity * sizeof(int));

    struct Queue *queue = createQueue(capacity);
    enqueue(queue, root);

    int level = 0;
    while (!isEmpty(queue)) {
        if (level >= capacity) {
            capacity *= 2;
            result = (int **)realloc(result, capacity * sizeof(int *));
            *returnColumnSizes = (int *)realloc(*returnColumnSizes, capacity * sizeof(int));
        }

        int size = queue->size;
        result[level] = (int *)malloc(size * sizeof(int));
        (*returnColumnSizes)[level] = size;

        for (int i = 0; i < size; i++) {
            struct Node *current = dequeue(queue);
            result[level][i] = current->val;
            for (int j = 0; j < current->childrenSize; j++) {
                enqueue(queue, current->children[j]);
            }
        }

        level++;
    }

    freeQueue(queue);
    *returnSize = level;
    return result;
}