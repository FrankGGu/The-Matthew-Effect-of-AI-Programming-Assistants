#include <vector>

class Solution {
public:
    std::vector<int> postorderTraversal(TreeNode* root) {
        std::vector<int> result;
        traverse(root, result);
        return result;
    }

private:
    void traverse(TreeNode* node, std::vector<int>& result) {
        if (node == nullptr) {
            return;
        }
        traverse(node->left, result);
        traverse(node->right, result);
        result.push_back(node->val);
    }
};