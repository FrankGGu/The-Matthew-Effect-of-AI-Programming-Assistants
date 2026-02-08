#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct QueueNode {
    struct TreeNode *node;
    int col;
};

struct Queue {
    struct QueueNode *items;
    int front;
    int rear;
    int capacity;
};

struct Queue* createQueue(int capacity) {
    struct Queue* queue = (struct Queue*)malloc(sizeof(struct Queue));
    queue->capacity = capacity;
    queue->front = 0;
    queue->rear = -1;
    queue->items = (struct QueueNode*)malloc(queue->capacity * sizeof(struct QueueNode));
    return queue;
}

int isEmpty(struct Queue* queue) {
    return queue->front > queue->rear;
}

void enqueue(struct Queue* queue, struct TreeNode* node, int col) {
    queue->rear++;
    queue->items[queue->rear].node = node;
    queue->items[queue->rear].col = col;
}

struct QueueNode dequeue(struct Queue* queue) {
    struct QueueNode item = queue->items[queue->front];
    queue->front++;
    return item;
}

int** verticalTraversal(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int minCol = 0, maxCol = 0;
    struct Queue* queue = createQueue(1000); 
    enqueue(queue, root, 0);

    struct Queue* tempQueue = createQueue(1000);

    while (!isEmpty(queue)) {
        struct QueueNode curr = dequeue(queue);
        struct TreeNode* node = curr.node;
        int col = curr.col;

        if (col < minCol) minCol = col;
        if (col > maxCol) maxCol = col;

        if (node->left) enqueue(tempQueue, node->left, col - 1);
        if (node->right) enqueue(tempQueue, node->right, col + 1);

        if(isEmpty(queue)){
            struct Queue* tmp = queue;
            queue = tempQueue;
            tempQueue = tmp;
            tempQueue->front = 0;
            tempQueue->rear = -1;
        }
    }

    free(tempQueue->items);
    free(tempQueue);

    int numCols = maxCol - minCol + 1;
    int** result = (int**)malloc(numCols * sizeof(int*));
    *returnColumnSizes = (int*)malloc(numCols * sizeof(int));
    *returnSize = numCols;

    for (int i = 0; i < numCols; i++) {
        (*returnColumnSizes)[i] = 0;
        result[i] = (int*)malloc(1000 * sizeof(int));
    }

    queue->front = 0;
    queue->rear = -1;
    enqueue(queue, root, 0);

    while (!isEmpty(queue)) {
        int qSize = queue->rear - queue->front + 1;

        struct TreeNode* levelNodes[qSize];
        int levelCols[qSize];
        int levelSize = 0;

        for(int i = 0; i < qSize; i++){
            struct QueueNode curr = dequeue(queue);
            struct TreeNode* node = curr.node;
            int col = curr.col;

            levelNodes[levelSize] = node;
            levelCols[levelSize] = col;
            levelSize++;

            if (node->left) enqueue(queue, node->left, col - 1);
            if (node->right) enqueue(queue, node->right, col + 1);
        }

        for(int i = 0; i < levelSize; i++){
            for(int j = i+1; j < levelSize; j++){
                if(levelCols[i] == levelCols[j]){
                    if(levelNodes[i]->val > levelNodes[j]->val){
                        int tempVal = levelNodes[i]->val;
                        levelNodes[i]->val = levelNodes[j]->val;
                        levelNodes[j]->val = tempVal;
                    }
                }
            }
        }

        for(int i = 0; i < levelSize; i++){
            int colIndex = levelCols[i] - minCol;
            result[colIndex][(*returnColumnSizes)[colIndex]] = levelNodes[i]->val;
            (*returnColumnSizes)[colIndex]++;
        }
    }

    free(queue->items);
    free(queue);

    return result;
}