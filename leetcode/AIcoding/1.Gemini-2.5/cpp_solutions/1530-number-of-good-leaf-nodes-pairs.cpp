#include <vector>
#include <algorithm>

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
    int good_pairs_count;
    int max_distance_limit;

    std::vector<int> dfs(TreeNode* node) {
        if (node == nullptr) {
            return {};
        }

        if (node->left == nullptr && node->right == nullptr) {
            // This is a leaf node. Distance from itself to itself is 0,
            // which means distance from its parent to this leaf would be 1.
            return {0};
        }

        std::vector<int> left_leaf_distances = dfs(node->left);
        std::vector<int> right_leaf_distances = dfs(node->right);

        // Calculate good pairs between leaves in left and right subtrees
        for (int d1 : left_leaf_distances) {
            for (int d2 : right_leaf_distances) {
                // d1 is distance from node->left to a leaf in its subtree
                // d2 is distance from node->right to a leaf in its subtree
                // Total distance between these two leaves is (d1 + 1) + (d2 + 1)
                if ((d1 + 1) + (d2 + 1) <= max_distance_limit) {
                    good_pairs_count++;
                }
            }
        }

        // Prepare distances for the parent node
        std::vector<int> current_node_distances;
        for (int d : left_leaf_distances) {
            if (d + 1 <= max_distance_limit) { // Only propagate distances that are still within the limit
                current_node_distances.push_back(d + 1);
            }
        }
        for (int d : right_leaf_distances) {
            if (d + 1 <= max_distance_limit) { // Only propagate distances that are still within the limit
                current_node_distances.push_back(d + 1);
            }
        }
        return current_node_distances;
    }

    int countPairs(TreeNode* root, int distance) {
        good_pairs_count = 0;
        max_distance_limit = distance;
        dfs(root);
        return good_pairs_count;
    }
};