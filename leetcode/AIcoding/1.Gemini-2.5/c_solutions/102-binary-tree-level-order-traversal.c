#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode** data;
    int front;
    int rear;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->data = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * capacity);
    return q;
}

void enqueue(Queue* q, struct TreeNode* node) {
    if ((q->rear + 1) % q->capacity == q->front && q->rear != -1) { // Queue is full
        int old_capacity = q->capacity;
        q->capacity *= 2;
        struct TreeNode** new_data = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * q->capacity);
        int i = 0;
        int current = q->front;
        while (current != (q->rear + 1) % old_capacity) {
            new_data[i++] = q->data[current];
            current = (current + 1) % old_capacity;
        }
        free(q->data);
        q->data = new_data;
        q->front = 0;
        q->rear = i - 1;
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = node;
}

struct TreeNode* dequeue(Queue* q) {
    if (q->front == (q->rear + 1) % q->capacity && q->rear != -1) { // Queue is empty
        return NULL;
    }
    struct TreeNode* node = q->data[q->front];
    if (q->front == q->rear) { // Last element in queue
        q->front = 0;
        q->rear = -1;
    } else {
        q->front = (q->front + 1) % q->capacity;
    }
    return node;
}

int isQueueEmpty(Queue* q) {
    return q->rear == -1;
}

int queueSize(Queue* q) {
    if (q->rear == -1) return 0;
    if (q->rear >= q->front) {
        return q->rear - q->front + 1;
    } else {
        return q->capacity - q->front + q->rear + 1;
    }
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int** levelOrder(struct TreeNode* root, int* returnSize, int** columnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        *columnSizes = NULL;
        return NULL;
    }

    Queue* q = createQueue(100);
    enqueue(q, root);

    int** result = NULL;
    *returnSize = 0;
    *columnSizes = NULL;
    int result_capacity = 10;

    result = (int**)malloc(sizeof(int*) * result_capacity);
    *columnSizes = (int*)malloc(sizeof(int) * result_capacity);

    while (!isQueueEmpty(q)) {
        int level_size = queueSize(q);
        int* current_level_nodes = (int*)malloc(sizeof(int) * level_size);

        if (*returnSize == result_capacity) {
            result_capacity *= 2;
            result = (int**)realloc(result, sizeof(int*) * result_capacity);
            *columnSizes = (int*)realloc(*columnSizes, sizeof(int) * result_capacity);
        }

        for (int i = 0; i < level_size; i++) {
            struct TreeNode* node = dequeue(q);
            current_level_nodes[i] = node->val;

            if (node->left != NULL) {
                enqueue(q, node->left);
            }
            if (node->right != NULL) {
                enqueue(q, node->right);
            }
        }
        result[*returnSize] = current_level_nodes;
        (*columnSizes)[*returnSize] = level_size;
        (*returnSize)++;
    }

    freeQueue(q);
    return result;
}