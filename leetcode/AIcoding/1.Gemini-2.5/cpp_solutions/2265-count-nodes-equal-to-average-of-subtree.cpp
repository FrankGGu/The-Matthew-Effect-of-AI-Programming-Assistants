#include <utility> // Required for std::pair

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
    int ans = 0;

    std::pair<int, int> dfs(TreeNode* node) {
        if (node == nullptr) {
            return {0, 0};
        }

        std::pair<int, int> left_res = dfs(node->left);
        std::pair<int, int> right_res = dfs(node->right);

        int current_sum = node->val + left_res.first + right_res.first;
        int current_count = 1 + left_res.second + right_res.second;

        if (node->val == current_sum / current_count) {
            ans++;
        }

        return {current_sum, current_count};
    }

    int averageOfSubtree(TreeNode* root) {
        ans = 0;
        dfs(root);
        return ans;
    }
};