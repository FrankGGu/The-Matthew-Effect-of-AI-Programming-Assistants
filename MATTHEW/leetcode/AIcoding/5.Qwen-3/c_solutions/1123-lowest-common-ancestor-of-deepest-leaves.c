#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* lowestCommonAncestor(struct TreeNode* root, struct TreeNode* p, struct TreeNode* q) {
    if (root == NULL || root == p || root == q) {
        return root;
    }
    struct TreeNode* left = lowestCommonAncestor(root->left, p, q);
    struct TreeNode* right = lowestCommonAncestor(root->right, p, q);
    if (left && right) {
        return root;
    }
    return left ? left : right;
}

int depth(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }
    return 1 + fmax(depth(node->left), depth(node->right));
}

struct TreeNode* findDeepestLeaves(struct TreeNode* root, int currentDepth, int targetDepth) {
    if (root == NULL) {
        return NULL;
    }
    if (currentDepth == targetDepth) {
        return root;
    }
    struct TreeNode* left = findDeepestLeaves(root->left, currentDepth + 1, targetDepth);
    struct TreeNode* right = findDeepestLeaves(root->right, currentDepth + 1, targetDepth);
    if (left && right) {
        return lowestCommonAncestor(root, left, right);
    }
    return left ? left : right;
}

struct TreeNode* lcaDeepestLeaves(struct TreeNode* root) {
    int d = depth(root);
    return findDeepestLeaves(root, 1, d);
}