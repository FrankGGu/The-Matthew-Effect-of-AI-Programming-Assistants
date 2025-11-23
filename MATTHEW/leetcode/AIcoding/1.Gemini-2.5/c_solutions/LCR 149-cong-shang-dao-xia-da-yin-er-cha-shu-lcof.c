#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

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

int isQueueEmpty(Queue* q) {
    return q->front == NULL;
}

void freeQueue(Queue* q) {
    while (!isQueueEmpty(q)) {
        dequeue(q);
    }
    free(q);
}

int** levelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    *returnColumnSizes = NULL;

    if (root == NULL) {
        return NULL;
    }

    Queue* q = createQueue();
    enqueue(q, root);

    int** result = NULL;
    int* columnSizes = NULL;
    int capacity = 4;

    result = (int**)malloc(sizeof(int*) * capacity);
    columnSizes = (int*)malloc(sizeof(int) * capacity);

    while (!isQueueEmpty(q)) {
        int levelSize = q->size;
        int* currentLevel = NULL;
        int currentLevelCount = 0;
        int currentLevelCapacity = levelSize > 0 ? levelSize : 4;

        currentLevel = (int*)malloc(sizeof(int) * currentLevelCapacity);

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = dequeue(q);

            if (currentLevelCount == currentLevelCapacity) {
                currentLevelCapacity *= 2;
                currentLevel = (int*)realloc(currentLevel, sizeof(int) * currentLevelCapacity);
            }
            currentLevel[currentLevelCount++] = node->val;

            if (node->left != NULL) {
                enqueue(q, node->left);
            }
            if (node->right != NULL) {
                enqueue(q, node->right);
            }
        }

        if (*returnSize == capacity) {
            capacity *= 2;
            result = (int**)realloc(result, sizeof(int*) * capacity);
            columnSizes = (int*)realloc(columnSizes, sizeof(int) * capacity);
        }

        result[*returnSize] = (int*)realloc(currentLevel, sizeof(int) * currentLevelCount);
        columnSizes[*returnSize] = currentLevelCount;
        (*returnSize)++;
    }

    freeQueue(q);

    result = (int**)realloc(result, sizeof(int*) * (*returnSize));
    columnSizes = (int*)realloc(columnSizes, sizeof(int) * (*returnSize));

    *returnColumnSizes = columnSizes;
    return result;
}