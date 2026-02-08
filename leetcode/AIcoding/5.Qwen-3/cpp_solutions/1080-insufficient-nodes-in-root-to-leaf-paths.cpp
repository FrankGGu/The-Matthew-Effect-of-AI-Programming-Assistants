#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

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
    TreeNode* sufficientSubset(TreeNode* root, int limit) {
        return dfs(root, 0, limit);
    }

private:
    TreeNode* dfs(TreeNode* node, int currentSum, int limit) {
        if (node == nullptr) {
            return nullptr;
        }
        currentSum += node->val;
        if (node->left == nullptr && node->right == nullptr) {
            return (currentSum >= limit) ? node : nullptr;
        }
        node->left = dfs(node->left, currentSum, limit);
        node->right = dfs(node->right, currentSum, limit);
        return (node->left || node->right) ? node : nullptr;
    }
};