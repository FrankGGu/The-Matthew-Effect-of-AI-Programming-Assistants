#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool findTarget(struct TreeNode* root, int k) {
    if (!root) return false;

    int arr[10000];
    int size = 0;

    void inorder(struct TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        arr[size++] = node->val;
        inorder(node->right);
    }

    inorder(root);

    int left = 0;
    int right = size - 1;

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