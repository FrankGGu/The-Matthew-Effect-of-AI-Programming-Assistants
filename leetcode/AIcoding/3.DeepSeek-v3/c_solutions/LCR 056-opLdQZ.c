#include <stdlib.h>
#include <stdbool.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void inorder(struct TreeNode* root, int* arr, int* index) {
    if (root == NULL) return;
    inorder(root->left, arr, index);
    arr[(*index)++] = root->val;
    inorder(root->right, arr, index);
}

int countNodes(struct TreeNode* root) {
    if (root == NULL) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

bool findTarget(struct TreeNode* root, int k) {
    int n = countNodes(root);
    int* arr = (int*)malloc(n * sizeof(int));
    int index = 0;
    inorder(root, arr, &index);

    int left = 0, right = n - 1;
    while (left < right) {
        int sum = arr[left] + arr[right];
        if (sum == k) {
            free(arr);
            return true;
        } else if (sum < k) {
            left++;
        } else {
            right--;
        }
    }
    free(arr);
    return false;
}