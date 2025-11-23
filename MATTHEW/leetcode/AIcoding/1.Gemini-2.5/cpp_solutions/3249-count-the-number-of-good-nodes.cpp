#include <algorithm> // Required for std::max

class Solution {
public:
    int goodNodes(TreeNode* root) {
        if (!root) {
            return 0;
        }
        int count = 0;
        dfs(root, root->val, count);
        return count;
    }

private:
    void dfs(TreeNode* node, int max_so_far, int& count) {
        if (!node) {
            return;
        }

        if (node->val >= max_so_far) {
            count++;
        }

        int new_max_for_children = std::max(max_so_far, node->val);

        dfs(node->left, new_max_for_children, count);
        dfs(node->right, new_max_for_children, count);
    }
};