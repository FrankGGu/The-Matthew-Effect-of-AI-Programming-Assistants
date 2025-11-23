class Solution {
public:
    vector<int> flipMatchVoyage(TreeNode* root, vector<int>& voyage) {
        vector<int> res;
        int index = 0;
        if (dfs(root, voyage, index, res)) {
            return res;
        } else {
            return {-1};
        }
    }

    bool dfs(TreeNode* node, vector<int>& voyage, int& index, vector<int>& res) {
        if (!node) return true;
        if (node->val != voyage[index++]) return false;
        if (node->left && node->left->val != voyage[index]) {
            res.push_back(node->val);
            return dfs(node->right, voyage, index, res) && dfs(node->left, voyage, index, res);
        } else {
            return dfs(node->left, voyage, index, res) && dfs(node->right, voyage, index, res);
        }
    }
};