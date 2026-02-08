#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

typedef struct QueueNode {
    TreeNode* node;
    struct QueueNode* next;
} QueueNode;

typedef struct {
    QueueNode* front;
    QueueNode* rear;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    return q;
}

void enqueue(Queue* q, TreeNode* node) {
    QueueNode* newNode = (QueueNode*)malloc(sizeof(QueueNode));
    newNode->node = node;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = q->rear = newNode;
        return;
    }
    q->rear->next = newNode;
    q->rear = newNode;
}

TreeNode* dequeue(Queue* q) {
    if (q->front == NULL) return NULL;
    QueueNode* temp = q->front;
    TreeNode* node = temp->node;
    q->front = q->front->next;
    if (q->front == NULL) q->rear = NULL;
    free(temp);
    return node;
}

bool isQueueEmpty(Queue* q) {
    return q->front == NULL;
}

bool isEvenOddTree(struct TreeNode* root) {
    if (!root) return true;

    Queue* q = createQueue();
    enqueue(q, root);
    int level = 0;

    while (!isQueueEmpty(q)) {
        int size = 0;
        QueueNode* temp = q->front;
        while (temp) {
            size++;
            temp = temp->next;
        }

        int prevVal = -1;
        for (int i = 0; i < size; i++) {
            TreeNode* current = dequeue(q);
            if (level % 2 == 0) {
                if (current->val % 2 == 0 || (prevVal != -1 && current->val <= prevVal)) {
                    return false;
                }
            } else {
                if (current->val % 2 != 0 || (prevVal != -1 && current->val >= prevVal)) {
                    return false;
                }
            }
            prevVal = current->val;
            if (current->left) enqueue(q, current->left);
            if (current->right) enqueue(q, current->right);
        }
        level++;
    }

    return true;
}