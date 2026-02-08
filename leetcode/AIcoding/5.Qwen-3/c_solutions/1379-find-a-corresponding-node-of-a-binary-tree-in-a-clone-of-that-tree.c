#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* getTargetCopy(struct TreeNode* original, struct TreeNode* cloned, struct TreeNode* target) {
    if (original == NULL || cloned == NULL) {
        return NULL;
    }

    if (original == target) {
        return cloned;
    }

    struct TreeNode* left = getTargetCopy(original->left, cloned->left, target);
    if (left != NULL) {
        return left;
    }

    return getTargetCopy(original->right, cloned->right, target);
}