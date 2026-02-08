#include <algorithm> // Required for std::max
#include <limits>    // Required for std::numeric_limits<int>::min()

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
    int maxPathSum(TreeNode* root) {
        max_overall_sum = std::numeric_limits<int>::min();
        calculateMaxPathSum(root);
        return max_overall_sum;
    }

private:
    int max_overall_sum;

    int calculateMaxPathSum(TreeNode* node) {
        if (!node) {
            return 0;
        }

        int left_gain = std::max(0, calculateMaxPathSum(node->left));
        int right_gain = std::max(0, calculateMaxPathSum(node->right));

        int current_path_sum_through_node = node->val + left_gain + right_gain;
        max_overall_sum = std::max(max_overall_sum, current_path_sum_through_node);

        return node->val + std::max(left_gain, right_gain);
    }
};