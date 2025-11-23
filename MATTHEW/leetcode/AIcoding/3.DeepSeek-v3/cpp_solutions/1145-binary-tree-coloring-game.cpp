class Solution {
public:
    int left, right, val;
    bool btreeGameWinningMove(TreeNode* root, int n, int x) {
        val = x;
        count(root);
        return max(max(left, right), n - left - right - 1) > n / 2;
    }

    int count(TreeNode* node) {
        if (!node) return 0;
        int l = count(node->left);
        int r = count(node->right);
        if (node->val == val) {
            left = l;
            right = r;
        }
        return l + r + 1;
    }
};