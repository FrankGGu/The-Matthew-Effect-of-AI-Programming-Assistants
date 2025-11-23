#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct QueueNode {
    TreeNode *node;
    double distance;
    struct QueueNode *next;
} QueueNode;

typedef struct Queue {
    QueueNode *front;
    QueueNode *rear;
} Queue;

Queue* createQueue() {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    return q;
}

void enqueue(Queue *q, TreeNode *node, double distance) {
    QueueNode *newNode = (QueueNode*)malloc(sizeof(QueueNode));
    newNode->node = node;
    newNode->distance = distance;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = q->rear = newNode;
        return;
    }
    q->rear->next = newNode;
    q->rear = newNode;
}

TreeNode* dequeue(Queue *q) {
    if (q->front == NULL) return NULL;
    QueueNode *temp = q->front;
    TreeNode *node = temp->node;
    q->front = q->front->next;
    if (q->front == NULL) q->rear = NULL;
    free(temp);
    return node;
}

int isEmpty(Queue *q) {
    return q->front == NULL;
}

double min(double a, double b) {
    return (a < b) ? a : b;
}

double shortestPath(TreeNode* root) {
    if (!root) return 0.0;

    Queue *q = createQueue();
    enqueue(q, root, 0.0);

    double minDist = 1e9;

    while (!isEmpty(q)) {
        TreeNode *node = dequeue(q);
        if (!node->left && !node->right) {
            minDist = min(minDist, node->val);
            continue;
        }

        if (node->left) {
            enqueue(q, node->left, node->val + 1.0);
        }
        if (node->right) {
            enqueue(q, node->right, node->val + 1.0);
        }
    }

    free(q);
    return minDist;
}