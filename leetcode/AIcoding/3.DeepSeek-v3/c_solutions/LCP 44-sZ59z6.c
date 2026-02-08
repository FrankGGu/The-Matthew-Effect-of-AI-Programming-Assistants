/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

#define MAX_SIZE 1001

void dfs(struct TreeNode* root, int* colors, int* count) {
    if (root == NULL) return;

    if (colors[root->val] == 0) {
        (*count)++;
    }
    colors[root->val]++;

    dfs(root->left, colors, count);
    dfs(root->right, colors, count);
}

int numColor(struct TreeNode* root) {
    int colors[MAX_SIZE] = {0};
    int count = 0;
    dfs(root, colors, &count);
    return count;
}