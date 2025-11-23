#include <vector>
#include <stack>

class Solution {
public:
    std::vector<int> preorderTraversal(TreeNode* root) {
        std::vector<int> result;
        if (root == nullptr) {
            return result;
        }

        std::stack<TreeNode*> s;
        s.push(root);

        while (!s.empty()) {
            TreeNode* node = s.top();
            s.pop();
            result.push_back(node->val);

            if (node->right != nullptr) {
                s.push(node->right);
            }
            if (node->left != nullptr) {
                s.push(node->left);
            }
        }
        return result;
    }
};