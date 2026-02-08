#include <stdlib.h>

struct maxNode {
    int val;
    struct maxNode *next;
};

struct maxNode* addMax(struct maxNode* head, int val) {
    struct maxNode* newNode = (struct maxNode*)malloc(sizeof(struct maxNode));
    newNode->val = val;
    newNode->next = head;
    return newNode;
}

int* largestValues(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int capacity = 10;
    int* result = (int*)malloc(capacity * sizeof(int));
    *returnSize = 0;
    struct maxNode* queue = NULL;

    queue = addMax(queue, root->val);
    struct TreeNode* nodes[1000];
    int front = 0, rear = 0;

    nodes[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;
        int maxVal = INT_MIN;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* node = nodes[front++];
            if (node->val > maxVal) {
                maxVal = node->val;
            }
            if (node->left) {
                nodes[rear++] = node->left;
            }
            if (node->right) {
                nodes[rear++] = node->right;
            }
        }

        if (*returnSize >= capacity) {
            capacity *= 2;
            result = (int*)realloc(result, capacity * sizeof(int));
        }
        result[(*returnSize)++] = maxVal;
    }

    return result;
}