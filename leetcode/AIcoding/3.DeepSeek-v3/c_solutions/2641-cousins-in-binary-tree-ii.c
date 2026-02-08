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
    int size;
} Queue;

Queue* createQueue(int size) {
    Queue* queue = (Queue*)malloc(sizeof(Queue));
    queue->data = (struct TreeNode**)malloc(size * sizeof(struct TreeNode*));
    queue->front = 0;
    queue->rear = 0;
    queue->size = size;
    return queue;
}

void enqueue(Queue* queue, struct TreeNode* node) {
    queue->data[queue->rear++] = node;
}

struct TreeNode* dequeue(Queue* queue) {
    return queue->data[queue->front++];
}

int isEmpty(Queue* queue) {
    return queue->front == queue->rear;
}

void freeQueue(Queue* queue) {
    free(queue->data);
    free(queue);
}

struct TreeNode* replaceValueInTree(struct TreeNode* root) {
    if (!root) return NULL;

    Queue* q = createQueue(100000);
    enqueue(q, root);

    while (!isEmpty(q)) {
        int levelSize = q->rear - q->front;
        long levelSum = 0;

        struct TreeNode** levelNodes = (struct TreeNode**)malloc(levelSize * sizeof(struct TreeNode*));
        for (int i = 0; i < levelSize; i++) {
            levelNodes[i] = dequeue(q);
            levelSum += levelNodes[i]->val;
        }

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = levelNodes[i];
            long siblingSum = 0;

            if (node->left) siblingSum += node->left->val;
            if (node->right) siblingSum += node->right->val;

            if (node->left) {
                enqueue(q, node->left);
                node->left->val = levelSum - siblingSum;
            }
            if (node->right) {
                enqueue(q, node->right);
                node->right->val = levelSum - siblingSum;
            }
        }

        free(levelNodes);
    }

    root->val = 0;
    freeQueue(q);
    return root;
}