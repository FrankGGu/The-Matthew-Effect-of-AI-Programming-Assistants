#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int pseudoPalindromicPaths(struct TreeNode* root) {
    int count = 0;
    int path[10] = {0};

    function(root, path, &count);

    return count;
}

void function(struct TreeNode* node, int* path, int* count) {
    if (!node) return;

    path[node->val - 1]++;

    if (!node->left && !node->right) {
        int odd_count = 0;
        for (int i = 0; i < 10; i++) {
            if (path[i] % 2 != 0) {
                odd_count++;
            }
        }
        if (odd_count <= 1) {
            (*count)++;
        }
    } else {
        function(node->left, path, count);
        function(node->right, path, count);
    }

    path[node->val - 1]--;
}