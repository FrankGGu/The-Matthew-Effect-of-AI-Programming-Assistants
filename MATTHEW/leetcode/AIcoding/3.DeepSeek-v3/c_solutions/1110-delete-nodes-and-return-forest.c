#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode** delNodes(struct TreeNode* root, int* toDelete, int toDeleteSize, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    int deleteSet[1001] = {0};
    for (int i = 0; i < toDeleteSize; i++) {
        deleteSet[toDelete[i]] = 1;
    }

    struct TreeNode** forest = (struct TreeNode**)malloc(1000 * sizeof(struct TreeNode*));
    *returnSize = 0;

    struct TreeNode* processNode(struct TreeNode* node, int isRoot) {
        if (!node) return NULL;

        int shouldDelete = deleteSet[node->val];

        if (isRoot && !shouldDelete) {
            forest[(*returnSize)++] = node;
        }

        node->left = processNode(node->left, shouldDelete);
        node->right = processNode(node->right, shouldDelete);

        return shouldDelete ? NULL : node;
    }

    processNode(root, 1);
    return forest;
}