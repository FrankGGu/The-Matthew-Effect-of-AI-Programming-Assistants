#include <algorithm> // For std::max
#include <limits>    // For std::numeric_limits<int>::min()

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
    int goodNodes(TreeNode* root) {
        if (!root) {
            return 0;
        }
        return dfs(root, std::numeric_limits<int>::min());
    }

private:
    int dfs(TreeNode* node, int max_val_so_far) {
        if (!node) {
            return 0;
        }

        int current_good_nodes = 0;
        if (node->val >= max_val_so_far) {
            current_good_nodes = 1;
        }

        int new_max_val = std::max(max_val_so_far, node->val);

        current_good_nodes += dfs(node->left, new_max_val);
        current_good_nodes += dfs(node->right, new_max_val);

        return current_good_nodes;
    }
};