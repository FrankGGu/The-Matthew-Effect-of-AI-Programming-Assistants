#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int isPerfect(struct TreeNode* root, int height) {
    if (!root) return 1;
    if (!root->left && !root->right) return (height == 1);
    if (!root->left || !root->right) return 0;

    return isPerfect(root->left, height - 1) && isPerfect(root->right, height - 1);
}

int height(struct TreeNode* root) {
    if (!root) return 0;
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
}

int size(struct TreeNode* root) {
    if (!root) return 0;
    return 1 + size(root->left) + size(root->right);
}

void inorder(struct TreeNode* root, int* sizes, int* count, int k) {
    if (!root) return;

    inorder(root->left, sizes, count, k);

    int h = height(root);
    if (isPerfect(root, h)) {
        sizes[(*count)++] = size(root);
    }

    inorder(root->right, sizes, count, k);
}

int findKthLargest(struct TreeNode* root, int k) {
    int* sizes = (int*)malloc(10001 * sizeof(int));
    int count = 0;

    inorder(root, sizes, &count, k);

    if (count < k) {
        free(sizes);
        return -1;
    }

    for (int i = 0; i < k; i++) {
        for (int j = i + 1; j < count; j++) {
            if (sizes[i] < sizes[j]) {
                int temp = sizes[i];
                sizes[i] = sizes[j];
                sizes[j] = temp;
            }
        }
    }

    int result = sizes[k - 1];
    free(sizes);
    return result;
}