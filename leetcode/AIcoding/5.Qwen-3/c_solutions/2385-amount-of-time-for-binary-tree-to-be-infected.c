#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

typedef struct QueueNode {
    TreeNode *node;
    struct QueueNode *next;
} QueueNode;

typedef struct {
    QueueNode *front;
    QueueNode *rear;
} Queue;

Queue *createQueue() {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->front = q->rear = NULL;
    return q;
}

void enqueue(Queue *q, TreeNode *node) {
    QueueNode *newNode = (QueueNode *)malloc(sizeof(QueueNode));
    newNode->node = node;
    newNode->next = NULL;
    if (q->rear == NULL) {
        q->front = q->rear = newNode;
        return;
    }
    q->rear->next = newNode;
    q->rear = newNode;
}

TreeNode *dequeue(Queue *q) {
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

void freeQueue(Queue *q) {
    while (!isEmpty(q)) {
        dequeue(q);
    }
    free(q);
}

TreeNode *findTarget(TreeNode *root, int target) {
    if (root == NULL) return NULL;
    if (root->val == target) return root;
    TreeNode *left = findTarget(root->left, target);
    if (left != NULL) return left;
    return findTarget(root->right, target);
}

int amountOfTime(TreeNode *root, int start) {
    TreeNode *target = findTarget(root, start);
    if (target == NULL) return 0;

    Queue *queue = createQueue();
    enqueue(queue, target);
    int time = 0;

    while (!isEmpty(queue)) {
        int size = 0;
        QueueNode *current = queue->front;
        while (current != NULL) {
            size++;
            current = current->next;
        }

        for (int i = 0; i < size; i++) {
            TreeNode *node = dequeue(queue);
            if (node->left != NULL) enqueue(queue, node->left);
            if (node->right != NULL) enqueue(queue, node->right);
        }

        time++;
    }

    freeQueue(queue);
    return time - 1;
}