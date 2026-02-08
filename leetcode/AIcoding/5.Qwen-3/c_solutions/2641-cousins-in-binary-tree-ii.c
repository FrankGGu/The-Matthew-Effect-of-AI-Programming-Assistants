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
    if (!q->front) {
        q->front = q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
}

TreeNode *dequeue(Queue *q) {
    if (!q->front) return NULL;
    QueueNode *temp = q->front;
    TreeNode *node = temp->node;
    q->front = q->front->next;
    if (!q->front) q->rear = NULL;
    free(temp);
    return node;
}

int isEmpty(Queue *q) {
    return q->front == NULL;
}

TreeNode *createTreeNode(int val) {
    TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

TreeNode *replaceValueInTree(TreeNode *root) {
    if (!root) return NULL;

    Queue *q = createQueue();
    enqueue(q, root);

    while (!isEmpty(q)) {
        int size = 0;
        QueueNode *current = q->front;
        while (current) {
            size++;
            current = current->next;
        }

        int *levelSum = (int *)malloc(size * sizeof(int));
        int index = 0;

        Queue *tempQ = createQueue();
        while (!isEmpty(q)) {
            TreeNode *node = dequeue(q);
            levelSum[index++] = node->val;
            if (node->left) enqueue(tempQ, node->left);
            if (node->right) enqueue(tempQ, node->right);
        }

        int sum = 0;
        for (int i = 0; i < size; i++) {
            sum += levelSum[i];
        }

        index = 0;
        while (!isEmpty(tempQ)) {
            TreeNode *node = dequeue(tempQ);
            int siblingSum = 0;
            if (node->left) siblingSum += node->left->val;
            if (node->right) siblingSum += node->right->val;
            node->val = sum - levelSum[index] - siblingSum;
            enqueue(q, node);
            index++;
        }

        free(levelSum);
        free(tempQ);
    }

    return root;
}