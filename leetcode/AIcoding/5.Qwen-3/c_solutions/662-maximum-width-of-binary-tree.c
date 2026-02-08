#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct QueueNode {
    struct TreeNode *node;
    unsigned long long int index;
    struct QueueNode *next;
} QueueNode;

typedef struct {
    QueueNode *front;
    QueueNode *rear;
} Queue;

Queue* createQueue() {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    return q;
}

void enqueue(Queue *q, struct TreeNode *node, unsigned long long int index) {
    QueueNode *newNode = (QueueNode*)malloc(sizeof(QueueNode));
    newNode->node = node;
    newNode->index = index;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = q->rear = newNode;
        return;
    }
    q->rear->next = newNode;
    q->rear = newNode;
}

QueueNode* dequeue(Queue *q) {
    if (q->front == NULL) return NULL;
    QueueNode *temp = q->front;
    q->front = q->front->next;
    if (q->front == NULL) q->rear = NULL;
    return temp;
}

int widthOfBinaryTree(struct TreeNode* root) {
    if (!root) return 0;

    Queue *q = createQueue();
    enqueue(q, root, 0);

    int maxWidth = 0;

    while (q->front) {
        int size = 0;
        unsigned long long int leftIndex = 0, rightIndex = 0;

        for (int i = 0; i < 10000; i++) { // safe limit to prevent infinite loop
            QueueNode *current = dequeue(q);
            if (!current) break;
            size++;
            leftIndex = current->index;
            rightIndex = current->index;

            if (current->node->left) {
                enqueue(q, current->node->left, leftIndex * 2 + 1);
            }
            if (current->node->right) {
                enqueue(q, current->node->right, leftIndex * 2 + 2);
            }
        }

        maxWidth = (maxWidth < (int)(rightIndex - leftIndex + 1)) ? (int)(rightIndex - leftIndex + 1) : maxWidth;
    }

    return maxWidth;
}