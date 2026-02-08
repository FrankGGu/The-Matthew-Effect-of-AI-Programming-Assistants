class Solution {
public:
    vector<TreeNode*> delNodes(TreeNode* root, vector<int>& to_delete) {
        vector<TreeNode*> result;
        unordered_set<int> to_delete_set(to_delete.begin(), to_delete.end());
        helper(root, true, to_delete_set, result);
        return result;
    }

    TreeNode* helper(TreeNode* node, bool is_root, unordered_set<int>& to_delete_set, vector<TreeNode*>& result) {
        if (!node) return nullptr;
        bool deleted = to_delete_set.find(node->val) != to_delete_set.end();
        if (is_root && !deleted) {
            result.push_back(node);
        }
        node->left = helper(node->left, deleted, to_delete_set, result);
        node->right = helper(node->right, deleted, to_delete_set, result);
        return deleted ? nullptr : node;
    }
};