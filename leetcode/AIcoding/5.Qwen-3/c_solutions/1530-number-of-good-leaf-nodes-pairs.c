#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int count;
} Result;

int* dfs(struct TreeNode* node, int* result) {
    if (!node) return NULL;

    int* left = dfs(node->left, result);
    int* right = dfs(node->right, result);

    int* counts = (int*)calloc(101, sizeof(int));

    if (left) {
        for (int i = 0; i < 100; i++) {
            if (left[i] > 0) {
                counts[i + 1] += left[i];
            }
        }
        free(left);
    }

    if (right) {
        for (int i = 0; i < 100; i++) {
            if (right[i] > 0) {
                counts[i + 1] += right[i];
            }
        }
        free(right);
    }

    if (!node->left && !node->right) {
        counts[1]++;
    } else {
        for (int i = 0; i < 100; i++) {
            if (counts[i] > 0) {
                result[0] += counts[i];
            }
        }
    }

    return counts;
}

int numberOfGoodLeafNodesPairs(struct TreeNode* root) {
    int result = 0;
    dfs(root, &result);
    return result;
}