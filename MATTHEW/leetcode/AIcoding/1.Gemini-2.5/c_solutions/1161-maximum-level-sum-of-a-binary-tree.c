#include <stdlib.h>
#include <limits.h>

typedef struct QueueNode {
    struct TreeNode* treeNode;
    struct QueueNode* next;
} QueueNode;

typedef struct {
    QueueNode* front;
    QueueNode* rear;
    int size;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->front = NULL;
    q->rear = NULL;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, struct TreeNode* treeNode) {
    QueueNode* newNode = (QueueNode*)malloc(sizeof(QueueNode));
    newNode->treeNode = treeNode;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = newNode;
        q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
    q->size++;
}

struct TreeNode* dequeue(Queue* q) {
    if (q->front == NULL) {
        return NULL;
    }
    QueueNode* temp = q->front;
    struct TreeNode* treeNode = temp->treeNode;
    q->front = q->front->next;
    if (q->front == NULL) {
        q->rear = NULL;
    }
    free(temp);
    q->size--;
    return treeNode;
}

int isEmpty(Queue* q) {
    return q->front == NULL;
}

void freeQueue(Queue* q) {
    while (!isEmpty(q)) {
        dequeue(q);
    }
    free(q);
}

int maxLevelSum(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }

    Queue* q = createQueue();
    enqueue(q, root);

    long maxSum = LONG_MIN;
    int maxLevel = 1;
    int currentLevel = 1;

    while (!isEmpty(q)) {
        int levelSize = q->size;
        long currentLevelSum = 0;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = dequeue(q);
            currentLevelSum += node->val;

            if (node->left != NULL) {
                enqueue(q, node->left);
            }
            if (node->right != NULL) {
                enqueue(q, node->right);
            }
        }

        if (currentLevelSum > maxSum) {
            maxSum = currentLevelSum;
            maxLevel = currentLevel;
        }
        currentLevel++;
    }

    freeQueue(q);
    return maxLevel;
}