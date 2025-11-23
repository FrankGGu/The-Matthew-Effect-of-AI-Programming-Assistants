class Solution {
public:
    int leftSize = 0, rightSize = 0;

    int countNodes(TreeNode* root, int x) {
        if (!root) return 0;
        int left = countNodes(root->left, x);
        int right = countNodes(root->right, x);
        if (root->val == x) {
            leftSize = left;
            rightSize = right;
        }
        return left + right + 1;
    }

    bool btreeGameWinningMove(TreeNode* root, int n, int x) {
        countNodes(root, x);
        int parent = n - leftSize - rightSize - 1;
        return max({parent, leftSize, rightSize}) > n / 2;
    }
};