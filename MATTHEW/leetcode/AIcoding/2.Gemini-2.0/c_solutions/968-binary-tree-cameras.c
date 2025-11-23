#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minCameraCover(struct TreeNode* root) {
    int cameras = 0;

    int dfs(struct TreeNode* node, int* cam) {
        if (!node) {
            return 1;
        }

        int left = dfs(node->left, cam);
        int right = dfs(node->right, cam);

        if (left == 0 || right == 0) {
            (*cam)++;
            return 2;
        }

        if (left == 2 || right == 2) {
            return 1;
        }

        return 0;
    }

    if (dfs(root, &cameras) == 0) {
        cameras++;
    }

    return cameras;
}