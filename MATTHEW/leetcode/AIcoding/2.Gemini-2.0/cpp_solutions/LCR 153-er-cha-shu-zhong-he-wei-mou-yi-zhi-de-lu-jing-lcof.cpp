class Solution {
public:
    vector<vector<int>> pathSum(TreeNode* root, int targetSum) {
        vector<vector<int>> result;
        vector<int> currentPath;
        pathSumHelper(root, targetSum, currentPath, result);
        return result;
    }

private:
    void pathSumHelper(TreeNode* node, int targetSum, vector<int>& currentPath, vector<vector<int>>& result) {
        if (!node) {
            return;
        }

        currentPath.push_back(node->val);
        targetSum -= node->val;

        if (!node->left && !node->right && targetSum == 0) {
            result.push_back(currentPath);
        } else {
            pathSumHelper(node->left, targetSum, currentPath, result);
            pathSumHelper(node->right, targetSum, currentPath, result);
        }

        currentPath.pop_back();
    }
};