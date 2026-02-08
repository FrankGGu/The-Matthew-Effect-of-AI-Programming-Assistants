#include <vector>
#include <algorithm>

struct NodeInfo {
    bool is_perfect;
    int height;
    int size;
};

class Solution {
public:
    NodeInfo dfs(TreeNode* node, std::vector<int>& perfect_subtree_sizes) {
        if (!node) {
            return {true, -1, 0};
        }

        NodeInfo left_info = dfs(node->left, perfect_subtree_sizes);
        NodeInfo right_info = dfs(node->right, perfect_subtree_sizes);

        bool current_is_perfect = left_info.is_perfect && right_info.is_perfect && (left_info.height == right_info.height);
        int current_height = 1 + std::max(left_info.height, right_info.height);
        int current_size = 1 + left_info.size + right_info.size;

        if (current_is_perfect) {
            perfect_subtree_sizes.push_back(current_size);
        }

        return {current_is_perfect, current_height, current_size};
    }

    int kthLargestPerfectSubtreeSize(TreeNode* root, int k) {
        std::vector<int> perfect_subtree_sizes;
        dfs(root, perfect_subtree_sizes);

        std::sort(perfect_subtree_sizes.rbegin(), perfect_subtree_sizes.rend());

        return perfect_subtree_sizes[k - 1];
    }
};