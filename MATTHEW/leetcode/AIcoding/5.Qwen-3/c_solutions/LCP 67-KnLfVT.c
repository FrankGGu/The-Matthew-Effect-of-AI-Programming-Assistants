#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int size;
    int *data;
} Queue;

Queue* createQueue(int capacity) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->size = 0;
    q->data = (int*)malloc(capacity * sizeof(int));
    return q;
}

void enqueue(Queue *q, int value) {
    q->data[q->size++] = value;
}

int dequeue(Queue *q) {
    int val = q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
    q->size--;
    return val;
}

int isEmpty(Queue *q) {
    return q->size == 0;
}

void freeQueue(Queue *q) {
    free(q->data);
    free(q);
}

TreeNode* buildTree(int* nums, int numsSize) {
    if (numsSize == 0) return NULL;
    TreeNode *root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = nums[0];
    Queue *q = createQueue(numsSize);
    enqueue(q, 0);
    int index = 1;
    while (!isEmpty(q)) {
        int i = dequeue(q);
        if (index < numsSize) {
            root->left = (TreeNode*)malloc(sizeof(TreeNode));
            root->left->val = nums[index++];
            enqueue(q, index - 1);
        }
        if (index < numsSize) {
            root->right = (TreeNode*)malloc(sizeof(TreeNode));
            root->right->val = nums[index++];
            enqueue(q, index - 1);
        }
    }
    freeQueue(q);
    return root;
}

void freeTree(TreeNode* root) {
    if (root == NULL) return;
    freeTree(root->left);
    freeTree(root->right);
    free(root);
}

int** decorTree(int* nums, int numsSize, int* returnSize, int** returnColumnSizes) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }
    TreeNode *root = buildTree(nums, numsSize);
    int **result = (int**)malloc(numsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;
    Queue *q = createQueue(numsSize);
    enqueue(q, 0);
    int level = 0;
    while (!isEmpty(q)) {
        int levelSize = q->size;
        result[level] = (int*)malloc(levelSize * sizeof(int));
        *returnColumnSizes[level] = levelSize;
        for (int i = 0; i < levelSize; i++) {
            int index = dequeue(q);
            result[level][i] = nums[index];
            if (2 * index + 1 < numsSize) {
                enqueue(q, 2 * index + 1);
            }
            if (2 * index + 2 < numsSize) {
                enqueue(q, 2 * index + 2);
            }
        }
        level++;
    }
    freeQueue(q);
    *returnSize = level;
    freeTree(root);
    return result;
}