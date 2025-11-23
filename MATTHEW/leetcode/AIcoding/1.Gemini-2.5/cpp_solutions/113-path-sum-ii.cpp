#include <vector>
#include <numeric>

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    std::vector<std::vector<int>> pathSum(TreeNode* root, int targetSum) {
        std::vector<std::vector<int>> result;
        std::vector<int> currentPath;
        dfs(root, targetSum, currentPath, result);
        return result;
    }

private:
    void dfs(TreeNode* node, int targetSum, std::vector<int>& currentPath, std::vector<std::vector<int>>& result) {
        if (node == nullptr) {
            return;
        }

        currentPath.push_back(node->val);

        if (node->left == nullptr && node->right == nullptr) { // It's a leaf node
            if (targetSum == node->val) {
                result.push_back(currentPath);
            }
        } else {
            dfs(node->left, targetSum - node->val, currentPath, result);
            dfs(node->right, targetSum - node->val, currentPath, result);
        }

        currentPath.pop_back(); // Backtrack
    }
};