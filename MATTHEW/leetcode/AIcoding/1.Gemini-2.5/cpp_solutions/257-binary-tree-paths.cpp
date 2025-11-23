#include <vector>
#include <string>
#include <algorithm>

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
    std::vector<std::string> binaryTreePaths(TreeNode* root) {
        std::vector<std::string> result;
        if (!root) {
            return result;
        }

        dfs(root, "", result);
        return result;
    }

private:
    void dfs(TreeNode* node, std::string current_path, std::vector<std::string>& result) {
        if (current_path.empty()) {
            current_path = std::to_string(node->val);
        } else {
            current_path += "->" + std::to_string(node->val);
        }

        if (!node->left && !node->right) {
            result.push_back(current_path);
            return;
        }

        if (node->left) {
            dfs(node->left, current_path, result);
        }

        if (node->right) {
            dfs(node->right, current_path, result);
        }
    }
};