#include <string>
#include <algorithm> // Not strictly needed for string comparison, but often included

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
    std::string smallestString;

    void dfs(TreeNode* node, std::string currentPath) {
        if (!node) {
            return;
        }

        currentPath = char('a' + node->val) + currentPath;

        if (!node->left && !node->right) {
            if (smallestString.empty() || currentPath < smallestString) {
                smallestString = currentPath;
            }
            return;
        }

        dfs(node->left, currentPath);
        dfs(node->right, currentPath);
    }

    std::string smallestFromLeaf(TreeNode* root) {
        smallestString = "";
        dfs(root, "");
        return smallestString;
    }
};