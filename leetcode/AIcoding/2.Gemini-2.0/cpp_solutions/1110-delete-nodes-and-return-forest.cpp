class Solution {
public:
    vector<TreeNode*> delNodes(TreeNode* root, vector<int>& to_delete) {
        vector<TreeNode*> result;
        unordered_set<int> to_delete_set(to_delete.begin(), to_delete.end());

        function<TreeNode*(TreeNode*, bool)> dfs = [&](TreeNode* node, bool is_root) {
            if (!node) return (TreeNode*)nullptr;

            bool deleted = to_delete_set.count(node->val);

            node->left = dfs(node->left, deleted);
            node->right = dfs(node->right, deleted);

            if (deleted) {
                return (TreeNode*)nullptr;
            } else {
                if (is_root) {
                    result.push_back(node);
                }
                return node;
            }
        };

        TreeNode* res = dfs(root, true);

        return result;
    }
};