#include <stdlib.h>

long long total_increase;

long long dfs(int node_idx, int* costs, int n) {
    // Base case: If the current node is a leaf
    // A node is a leaf if its left child (2 * node_idx) would be out of bounds (greater than n).
    if (2 * node_idx > n) {
        return (long long)costs[node_idx - 1]; // Return its own cost as the path sum
    }

    // Recursively calculate the maximum path sum for the left child's subtree
    long long left_max_path_sum = dfs(2 * node_idx, costs, n);
    // Recursively calculate the maximum path sum for the right child's subtree
    long long right_max_path_sum = dfs(2 * node_idx + 1, costs, n);

    // Determine the maximum path sum required from the children to equalize their paths
    long long max_child_path = (left_max_path_sum > right_max_path_sum) ? left_max_path_sum : right_max_path_sum;

    // Add the increments needed to make both child paths equal to max_child_path
    total_increase += (max_child_path - left_max_path_sum);
    total_increase += (max_child_path - right_max_path_sum);

    // Return the total path sum from the current node upwards, after equalization
    return (long long)costs[node_idx - 1] + max_child_path;
}

int minIncrements(int* costs, int n) {
    total_increase = 0; // Initialize global variable for each test case
    dfs(1, costs, n);   // Start the DFS from the root (node 1)
    return (int)total_increase; // Return the accumulated total increments
}