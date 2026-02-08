#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* lowestCommonAncestor(struct TreeNode* root, struct TreeNode* p, struct TreeNode* q) {
    if (root == NULL || p == NULL || q == NULL) {
        return NULL;
    }

    if (p->val > q->val) {
        struct TreeNode* temp = p;
        p = q;
        q = temp;
    }

    while (root != NULL) {
        if (root->val > q->val) {
            root = root->left;
        } else if (root->val < p->val) {
            root = root->right;
        } else {
            return root;
        }
    }

    return NULL;
}