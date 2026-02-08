#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minIncrements(int n, std::vector<int>& cost) {
        long long total_increments = 0;

        // Iterate from the parents of leaves up to the root.
        // In a 0-indexed complete binary tree, nodes from n/2 to n-1 are leaves.
        // Parents of leaves are from (n/2 - 1) down to 0.
        for (int i = n / 2 - 1; i >= 0; --i) {
            int left_child_idx = 2 * i + 1;
            int right_child_idx = 2 * i + 2;

            // cost[left_child_idx] and cost[right_child_idx] already store
            // the maximum path sum from that child to any leaf in its subtree
            // (including its own initial cost and any increments made in its subtree).
            int left_path_sum = cost[left_child_idx];
            int right_path_sum = cost[right_child_idx];

            // To make paths from node i through its left and right children equal,
            // we need to increment the cost of the path that is currently smaller.
            // The difference is added to total_increments.
            total_increments += std::abs(left_path_sum - right_path_sum);

            // Update cost[i] to store the maximum path sum from node i to a leaf
            // in its subtree. This value will be used by its parent.
            // This is the original cost[i] plus the maximum of the two child path sums
            // (after they have been made equal, which means taking the max).
            cost[i] += std::max(left_path_sum, right_path_sum);
        }

        return total_increments;
    }
};