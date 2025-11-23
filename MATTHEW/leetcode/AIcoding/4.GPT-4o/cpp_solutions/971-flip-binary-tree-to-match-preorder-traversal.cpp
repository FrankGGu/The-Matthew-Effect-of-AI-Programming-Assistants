class Solution {
public:
    vector<TreeNode*> flipMatchVoyage(TreeNode* root, vector<int>& voyage) {
        vector<TreeNode*> result;
        if (dfs(root, voyage, result, 0) == -1) {
            return {-1};
        }
        return result;
    }

private:
    int dfs(TreeNode* node, vector<int>& voyage, vector<TreeNode*>& result, int index) {
        if (!node) return index;
        if (index >= voyage.size() || node->val != voyage[index]) return -1;

        index++;
        if (index < voyage.size() && node->left && node->left->val != voyage[index]) {
            result.push_back(node);
            return dfs(node->right, voyage, result, dfs(node->left, voyage, result, index));
        }
        return dfs(node->left, voyage, result, index) == -1 ? -1 : dfs(node->right, voyage, result, index);
    }
};