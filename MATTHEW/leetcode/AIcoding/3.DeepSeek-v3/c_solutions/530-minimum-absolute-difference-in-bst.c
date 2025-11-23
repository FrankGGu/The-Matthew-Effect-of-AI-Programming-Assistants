/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

void inorder(struct TreeNode* root, int* prev, int* minDiff) {
    if (root == NULL) return;

    inorder(root->left, prev, minDiff);

    if (*prev != -1) {
        int diff = root->val - *prev;
        if (diff < *minDiff) {
            *minDiff = diff;
        }
    }
    *prev = root->val;

    inorder(root->right, prev, minDiff);
}

int getMinimumDifference(struct TreeNode* root) {
    int prev = -1;
    int minDiff = INT_MAX;
    inorder(root, &prev, &minDiff);
    return minDiff;
}