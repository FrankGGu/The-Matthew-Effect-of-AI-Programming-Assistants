#include <utility> // For std::pair
#include <algorithm> // For std::max (though not directly used in the final simplified logic, good practice to include if considering max)

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
    std::pair<int, TreeNode*> dfs(TreeNode* node) {
        if (!node) {
            return {0, nullptr};
        }

        std::pair<int, TreeNode*> left_res = dfs(node->left);
        std::pair<int, TreeNode*> right_res = dfs(node->right);

        if (left_res.first == right_res.first) {
            return {left_res.first + 1, node};
        } else if (left_res.first > right_res.first) {
            return {left_res.first + 1, left_res.second};
        } else { // left_res.first < right_res.first
            return {right_res.first + 1, right_res.second};
        }
    }

    TreeNode* lcaDeepestLeaves(TreeNode* root) {
        return dfs(root).second;
    }
};