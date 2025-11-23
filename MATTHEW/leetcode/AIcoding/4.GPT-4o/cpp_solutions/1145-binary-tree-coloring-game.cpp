class Solution {
public:
    bool btreeGameWinningMove(TreeNode* root, int n, int x) {
        int left = countNodes(root->left);
        int right = countNodes(root->right);
        int parent = n - (left + right + 1);
        return max({left, right, parent}) > n / 2;
    }

private:
    int countNodes(TreeNode* node) {
        if (!node) return 0;
        return 1 + countNodes(node->left) + countNodes(node->right);
    }
};