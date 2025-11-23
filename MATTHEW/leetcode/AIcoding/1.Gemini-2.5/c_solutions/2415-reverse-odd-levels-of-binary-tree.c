#include <stdlib.h>

typedef struct {
    struct TreeNode** arr;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->arr = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, struct TreeNode* node) {
    q->rear = (q->rear + 1) % q->capacity;
    q->arr[q->rear] = node;
    q->size++;
}

struct TreeNode* dequeue(Queue* q) {
    struct TreeNode* node = q->arr[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return node;
}

int isQueueEmpty(Queue* q) {
    return q->size == 0;
}

int getQueueSize(Queue* q) {
    return q->size;
}

void freeQueue(Queue* q) {
    free(q->arr);
    free(q);
}

struct TreeNode* reverseOddLevels(struct TreeNode* root) {
    if (!root) {
        return NULL;
    }

    Queue* q = createQueue(2001);

    enqueue(q, root);

    int level = 0;

    while (!isQueueEmpty(q)) {
        int level_size = getQueueSize(q);

        struct TreeNode** current_level_nodes = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * level_size);
        int* current_level_values = (int*)malloc(sizeof(int) * level_size);

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* node = dequeue(q);
            current_level_nodes[i] = node;
            current_level_values[i] = node->val;

            if (node->left) {
                enqueue(q, node->left);
            }
            if (node->right) {
                enqueue(q, node->right);
            }
        }

        if (level % 2 == 1) {
            for (int i = 0; i < level_size / 2; i++) {
                int temp = current_level_values[i];
                current_level_values[i] = current_level_values[level_size - 1 - i];
                current_level_values[level_size - 1 - i] = temp;
            }

            for (int i = 0; i < level_size; i++) {
                current_level_nodes[i]->val = current_level_values[i];
            }
        }

        free(current_level_nodes);
        free(current_level_values);

        level++;
    }

    freeQueue(q);

    return root;
}