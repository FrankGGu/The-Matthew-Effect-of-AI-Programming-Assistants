#include <algorithm>
#include <climits>

class Solution {
public:
    int max_bst_sum = 0;

    struct NodeInfo {
        bool is_bst;
        int min_val;
        int max_val;
        int sum;
    };

    NodeInfo dfs(TreeNode* node) {
        if (!node) {
            return {true, INT_MAX, INT_MIN, 0};
        }

        NodeInfo left_info = dfs(node->left);
        NodeInfo right_info = dfs(node->right);

        if (left_info.is_bst && right_info.is_bst &&
            node->val > left_info.max_val && node->val < right_info.min_val) {

            int current_sum = left_info.sum + right_info.sum + node->val;
            max_bst_sum = std::max(max_bst_sum, current_sum);

            return {true,
                    std::min(left_info.min_val, node->val),
                    std::max(right_info.max_val, node->val),
                    current_sum};
        } else {
            return {false, INT_MIN, INT_MAX, 0};
        }
    }

    int maxSumBST(TreeNode* root) {
        dfs(root);
        return max_bst_sum;
    }
};