#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool findTarget(struct TreeNode* root, int k) {
    int arr[10000];
    int idx = 0;

    void inorder(struct TreeNode* node) {
        if (node == NULL) return;
        inorder(node->left);
        arr[idx++] = node->val;
        inorder(node->right);
    }

    inorder(root);

    int left = 0;
    int right = idx - 1;

    while (left < right) {
        int sum = arr[left] + arr[right];
        if (sum == k) {
            return true;
        } else if (sum < k) {
            left++;
        } else {
            right--;
        }
    }

    return false;
}