#include <vector>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

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
    // This DFS function returns a vector of three integers for each node:
    // dp[0]: The minimum cost if this node needs its parent to cover it.
    //        (This node itself does not have a camera, and its children do not cover it).
    // dp[1]: The minimum cost if this node is covered by one of its children.
    //        (This node itself does not have a camera).
    // dp[2]: The minimum cost if this node has a camera.
    std::vector<int> dfs(TreeNode* node) {
        if (!node) {
            // For a null node:
            // dp[0] = 0 (A null node doesn't need a parent to cover it, it's vacuously covered)
            // dp[1] = 0 (A null node is vacuously covered by its children, no cost)
            // dp[2] = infinity (A null node cannot have a camera)
            // We use INT_MAX / 2 to prevent potential integer overflow when adding costs.
            return {0, 0, std::numeric_limits<int>::max() / 2};
        }

        std::vector<int> left_dp = dfs(node->left);
        std::vector<int> right_dp = dfs(node->right);

        std::vector<int> current_dp(3);

        // Calculate dp[0]: node needs parent to cover it.
        // This implies that the node itself has no camera, and its children also do not cover it.
        // Therefore, its children must be in state 1 (covered by their own children).
        current_dp[0] = left_dp[1] + right_dp[1];

        // Calculate dp[1]: node is covered by one of its children.
        // This implies that the node itself has no camera, but at least one of its children has a camera.
        // We take the minimum of two scenarios:
        // 1. Left child has a camera (left_dp[2]). Right child can either be covered by its child (right_dp[1])
        //    or have a camera itself (right_dp[2]).
        // 2. Right child has a camera (right_dp[2]). Left child can either be covered by its child (left_dp[1])
        //    or have a camera itself (left_dp[2]).
        current_dp[1] = std::min(left_dp[2] + std::min(right_dp[1], right_dp[2]),
                                 right_dp[2] + std::min(left_dp[1], left_dp[2]));

        // Calculate dp[2]: node has a camera.
        // The cost is 1 for the camera at this node.
        // Since this node has a camera, it covers itself, its parent, and its children.
        // Therefore, its children can be in any of the three states (needs parent, covered by child, or has camera),
        // and we choose the minimum cost for each child.
        current_dp[2] = 1 + std::min({left_dp[0], left_dp[1], left_dp[2]}) +
                            std::min({right_dp[0], right_dp[1], right_dp[2]});

        return current_dp;
    }

    int minCameraCover(TreeNode* root) {
        std::vector<int> result_dp = dfs(root);
        // The root node cannot be in state 0 (needs parent to cover it),
        // because it has no parent. Thus, the final answer must be the minimum
        // cost where the root is either covered by one of its children (state 1)
        // or has a camera itself (state 2).
        return std::min(result_dp[1], result_dp[2]);
    }
};