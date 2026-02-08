#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int minCameraCover(struct TreeNode* root);

int minCameraCover(struct TreeNode* root) {
    int cameras = 0;
    int solve(struct TreeNode* node) {
        if (!node) return 1;

        int left = solve(node->left);
        int right = solve(node->right);

        if (left == 0 || right == 0) {
            cameras++;
            return 2;
        }

        if (left == 2 || right == 2) {
            return 1;
        }

        return 0;
    }

    if (solve(root) == 0) {
        cameras++;
    }

    return cameras;
}