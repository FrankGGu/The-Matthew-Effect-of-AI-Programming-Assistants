#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* createNode(int val) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

struct TreeNode* addOneRow(struct TreeNode* root, int val, int depth) {
    if (depth == 1) {
        struct TreeNode* newRoot = createNode(val);
        newRoot->left = root;
        return newRoot;
    }

    struct TreeNode** queue = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;
    queue[rear++] = root;
    int currentDepth = 1;

    while (front < rear) {
        int levelSize = rear - front;
        if (currentDepth == depth - 1) {
            for (int i = 0; i < levelSize; i++) {
                struct TreeNode* node = queue[front++];

                struct TreeNode* leftChild = createNode(val);
                leftChild->left = node->left;
                node->left = leftChild;

                struct TreeNode* rightChild = createNode(val);
                rightChild->right = node->right;
                node->right = rightChild;
            }
            break;
        } else {
            for (int i = 0; i < levelSize; i++) {
                struct TreeNode* node = queue[front++];
                if (node->left) queue[rear++] = node->left;
                if (node->right) queue[rear++] = node->right;
            }
            currentDepth++;
        }
    }

    free(queue);
    return root;
}