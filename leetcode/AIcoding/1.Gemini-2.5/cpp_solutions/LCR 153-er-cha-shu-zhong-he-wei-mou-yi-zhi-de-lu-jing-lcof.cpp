class Solution {
public:
    std::vector<std::vector<int>> result;
    std::vector<int> currentPath;

    void dfs(TreeNode* node, int targetSum) {
        if (!node) {
            return;
        }

        currentPath.push_back(node->val);
        targetSum -= node->val;

        if (!node->left && !node->right && targetSum == 0) {
            result.push_back(currentPath);
        }

        dfs(node->left, targetSum);
        dfs(node->right, targetSum);

        currentPath.pop_back();
    }

    std::vector<std::vector<int>> pathSum(TreeNode* root, int targetSum) {
        result.clear();
        currentPath.clear();
        dfs(root, targetSum);
        return result;
    }
};