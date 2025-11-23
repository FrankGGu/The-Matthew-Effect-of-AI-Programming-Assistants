#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** queue;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * capacity);
    return q;
}

void enqueue(Queue* q, struct TreeNode* node) {
    if (q->rear == q->capacity - 1) {
        q->capacity *= 2;
        q->queue = (struct TreeNode**)realloc(q->queue, sizeof(struct TreeNode*) * q->capacity);
    }
    q->queue[++(q->rear)] = node;
}

struct TreeNode* dequeue(Queue* q) {
    if (q->front > q->rear) {
        return NULL;
    }
    return q->queue[(q->front)++];
}

int isEmpty(Queue* q) {
    return q->front > q->rear;
}

int queueSize(Queue* q) {
    return q->rear - q->front + 1;
}

void freeQueue(Queue* q) {
    free(q->queue);
    free(q);
}

int** zigzagLevelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (root == NULL) {
        return NULL;
    }

    Queue* q = createQueue(100);
    enqueue(q, root);

    int max_levels = 0;
    int current_capacity = 10;
    result = (int**)malloc(sizeof(int*) * current_capacity);
    *returnColumnSizes = (int*)malloc(sizeof(int) * current_capacity);

    while (!isEmpty(q)) {
        int level_size = queueSize(q);
        int* current_level_vals = (int*)malloc(sizeof(int) * level_size);

        if (*returnSize == current_capacity) {
            current_capacity *= 2;
            result = (int**)realloc(result, sizeof(int*) * current_capacity);
            *returnColumnSizes = (int*)realloc(*returnColumnSizes, sizeof(int) * current_capacity);
        }

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* node = dequeue(q);
            current_level_vals[i] = node->val;

            if (node->left != NULL) {
                enqueue(q, node->left);
            }
            if (node->right != NULL) {
                enqueue(q, node->right);
            }
        }

        result[*returnSize] = current_level_vals;
        (*returnColumnSizes)[*returnSize] = level_size;
        (*returnSize)++;
    }

    // Reverse the order of levels for Level Order Traversal II
    for (int i = 0; i < *returnSize / 2; i++) {
        int* temp_arr = result[i];
        result[i] = result[*returnSize - 1 - i];
        result[*returnSize - 1 - i] = temp_arr;

        int temp_col_size = (*returnColumnSizes)[i];
        (*returnColumnSizes)[i] = (*returnColumnSizes)[*returnSize - 1 - i];
        (*returnColumnSizes)[*returnSize - 1 - i] = temp_col_size;
    }

    freeQueue(q);
    return result;
}