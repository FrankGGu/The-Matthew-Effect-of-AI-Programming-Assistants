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
    int max_path_sum_global;

    int maxPathSumDFS(TreeNode* node) {
        if (node == nullptr) {
            return 0;
        }

        int left_gain = std::max(0, maxPathSumDFS(node->left));
        int right_gain = std::max(0, maxPathSumDFS(node->right));

        int current_path_sum = node->val + left_gain + right_gain;
        max_path_sum_global = std::max(max_path_sum_global, current_path_sum);

        return node->val + std::max(left_gain, right_gain);
    }

    int maxPathSum(TreeNode* root) {
        max_path_sum_global = std::numeric_limits<int>::min();
        maxPathSumDFS(root);
        return max_path_sum_global;
    }
};