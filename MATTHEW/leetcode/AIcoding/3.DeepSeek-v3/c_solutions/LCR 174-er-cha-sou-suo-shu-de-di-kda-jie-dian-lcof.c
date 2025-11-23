/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int countNodes(struct TreeNode* root) {
    if (root == NULL) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

void inorder(struct TreeNode* root, int* arr, int* index) {
    if (root == NULL) return;
    inorder(root->left, arr, index);
    arr[(*index)++] = root->val;
    inorder(root->right, arr, index);
}

int findTargetNode(struct TreeNode* root, int cnt) {
    int n = countNodes(root);
    int* arr = (int*)malloc(n * sizeof(int));
    int index = 0;
    inorder(root, arr, &index);
    return arr[n - cnt];
}