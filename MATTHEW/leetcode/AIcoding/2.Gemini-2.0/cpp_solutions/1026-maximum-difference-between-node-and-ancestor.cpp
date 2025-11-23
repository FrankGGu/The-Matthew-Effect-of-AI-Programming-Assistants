class Solution {
public:
    int maxAncestorDiff(TreeNode* root) {
        int maxDiff = 0;
        function<void(TreeNode*, int, int)> dfs = 
            [&](TreeNode* node, int minVal, int maxVal) {
            if (!node) return;
            maxDiff = max(maxDiff, max(abs(node->val - minVal), abs(node->val - maxVal)));
            minVal = min(minVal, node->val);
            maxVal = max(maxVal, node->val);
            dfs(node->left, minVal, maxVal);
            dfs(node->right, minVal, maxVal);
        };

        dfs(root, root->val, root->val);
        return maxDiff;
    }
};