#include <algorithm> // Required for std::max

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
private:
    int max_diameter = 0;

    int dfs(TreeNode* node) {
        if (!node) {
            return 0;
        }

        int left_height = dfs(node->left);
        int right_height = dfs(node->right);

        max_diameter = std::max(max_diameter, left_height + right_height);

        return 1 + std::max(left_height, right_height);
    }

public:
    int diameterOfBinaryTree(TreeNode* root) {
        max_diameter = 0;
        dfs(root);
        return max_diameter;
    }
};