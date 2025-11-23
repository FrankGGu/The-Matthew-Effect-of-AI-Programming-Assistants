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

struct Result helper(struct TreeNode *root, int depth) {
    struct Result res;
    if (!root) {
        res.node = NULL;
        res.depth = depth;
        return res;
    }

    struct Result leftRes = helper(root->left, depth + 1);
    struct Result rightRes = helper(root->right, depth + 1);

    if (leftRes.depth > rightRes.depth) {
        return leftRes;
    } else if (leftRes.depth < rightRes.depth) {
        return rightRes;
    } else {
        res.node = root;
        res.depth = leftRes.depth;
        return res;
    }
}

struct TreeNode* lcaDeepestLeaves(struct TreeNode* root) {
    struct Result res = helper(root, 0);
    return res.node;
}