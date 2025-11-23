#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

#define NOT_CAMERA 0
#define HAS_CAMERA 1
#define NEED_CAMERA 2

int dfs(TreeNode* root) {
    if (!root) return NOT_CAMERA;

    int left = dfs(root->left);
    int right = dfs(root->right);

    if (left == NEED_CAMERA || right == NEED_CAMERA) {
        return HAS_CAMERA;
    } else if (left == HAS_CAMERA || right == HAS_CAMERA) {
        return NOT_CAMERA;
    } else {
        return NEED_CAMERA;
    }
}

int minCameraCover(TreeNode* root) {
    int result = dfs(root);
    return (result == NEED_CAMERA) ? 1 : result;
}