#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* getTargetCopy(struct TreeNode* original, struct TreeNode* cloned, struct TreeNode* target) {
    if (!original) {
        return NULL;
    }

    if (original == target) {
        return cloned;
    }

    struct TreeNode* left = getTargetCopy(original->left, cloned->left, target);
    if (left) {
        return left;
    }

    return getTargetCopy(original->right, cloned->right, target);
}