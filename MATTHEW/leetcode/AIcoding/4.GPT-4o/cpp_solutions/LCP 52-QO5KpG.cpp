class Solution {
public:
    vector<int> treeColoring(TreeNode* root) {
        vector<int> result;
        if (!root) return result;
        dfs(root, result);
        return result;
    }

private:
    void dfs(TreeNode* node, vector<int>& result) {
        if (!node) return;
        result.push_back(node->val);
        dfs(node->left, result);
        dfs(node->right, result);
    }
};