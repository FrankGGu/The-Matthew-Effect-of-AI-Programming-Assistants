/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int leftSubtree, rightSubtree;

int countNodes(struct TreeNode* root) {
    if (!root) return 0;
    int left = countNodes(root->left);
    int right = countNodes(root->right);
    return left + right + 1;
}

bool findNode(struct TreeNode* root, int x) {
    if (!root) return false;
    if (root->val == x) {
        leftSubtree = countNodes(root->left);
        rightSubtree = countNodes(root->right);
        return true;
    }
    return findNode(root->left, x) || findNode(root->right, x);
}

bool btreeGameWinningMove(struct TreeNode* root, int n, int x) {
    leftSubtree = 0;
    rightSubtree = 0;
    findNode(root, x);
    int parentSubtree = n - leftSubtree - rightSubtree - 1;
    int maxSubtree = (leftSubtree > rightSubtree) ? leftSubtree : rightSubtree;
    maxSubtree = (maxSubtree > parentSubtree) ? maxSubtree : parentSubtree;
    return maxSubtree > n / 2;
}