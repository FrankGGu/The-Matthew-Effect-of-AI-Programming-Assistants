#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct Result {
    struct TreeNode *node;
    int depth;
};

struct Result helper(struct TreeNode* root) {
    if (root == NULL) {
        struct Result res = {NULL, 0};
        return res;
    }

    struct Result leftRes = helper(root->left);
    struct Result rightRes = helper(root->right);

    if (leftRes.depth > rightRes.depth) {
        leftRes.depth++;
        return leftRes;
    } else if (leftRes.depth < rightRes.depth) {
        rightRes.depth++;
        return rightRes;
    } else {
        struct Result res = {root, leftRes.depth + 1};
        return res;
    }
}

struct TreeNode* subtreeWithAllDeepest(struct TreeNode* root) {
    struct Result res = helper(root);
    return res.node;
}