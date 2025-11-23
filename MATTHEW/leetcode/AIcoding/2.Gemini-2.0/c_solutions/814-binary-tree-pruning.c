#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool containsOne(struct TreeNode* root) {
    if (!root) return false;

    bool leftContainsOne = containsOne(root->left);
    bool rightContainsOne = containsOne(root->right);

    if (!leftContainsOne) {
        root->left = NULL;
    }
    if (!rightContainsOne) {
        root->right = NULL;
    }

    return root->val == 1 || leftContainsOne || rightContainsOne;
}

struct TreeNode* pruneTree(struct TreeNode* root) {
    if (!root) return NULL;

    if (!containsOne(root)) {
        return NULL;
    }

    return root;
}