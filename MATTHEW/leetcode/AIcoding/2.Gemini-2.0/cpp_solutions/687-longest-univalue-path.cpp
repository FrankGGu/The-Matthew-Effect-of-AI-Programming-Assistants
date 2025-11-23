class Solution {
public:
    int longestUnivaluePath(TreeNode* root) {
        int ans = 0;
        function<int(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return 0;
            int left = dfs(node->left);
            int right = dfs(node->right);
            int arrowLeft = 0, arrowRight = 0;
            if (node->left && node->left->val == node->val) {
                arrowLeft += left + 1;
            }
            if (node->right && node->right->val == node->val) {
                arrowRight += right + 1;
            }
            ans = max(ans, arrowLeft + arrowRight);
            return max(arrowLeft, arrowRight);
        };
        dfs(root);
        return ans;
    }
};