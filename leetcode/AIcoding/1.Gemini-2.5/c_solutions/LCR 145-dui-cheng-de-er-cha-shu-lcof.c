#include <stdbool.h>
#include <stddef.h>

bool isMirror(struct TreeNode* p, struct TreeNode* q) {
    if (!p && !q) {
        return true;
    }
    if (!p || !q || p->val != q->val) {
        return false;
    }
    return isMirror(p->left, q->right) && isMirror(p->right, q->left);
}

bool isSymmetric(struct TreeNode* root) {
    if (!root) {
        return true;
    }
    return isMirror(root->left, root->right);
}