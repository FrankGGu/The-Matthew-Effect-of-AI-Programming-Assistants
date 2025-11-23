#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode* lowestCommonAncestor(struct TreeNode* root, struct TreeNode* p, struct TreeNode* q) {
    if (root == NULL) {
        return NULL;
    }

    if (p->val > q->val) {
        struct TreeNode* temp = p;
        p = q;
        q = temp;
    }

    if (root->val >= p->val && root->val <= q->val) {
        return root;
    } else if (root->val > q->val) {
        return lowestCommonAncestor(root->left, p, q);
    } else {
        return lowestCommonAncestor(root->right, p, q);
    }
}