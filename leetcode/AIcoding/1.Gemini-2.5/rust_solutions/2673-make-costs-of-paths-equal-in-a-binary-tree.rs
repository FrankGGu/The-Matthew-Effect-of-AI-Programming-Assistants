impl Solution {
    pub fn make_costs_equal_in_binary_tree(mut costs: Vec<i32>) -> i32 {
        let n = costs.len();
        let mut total_cost = 0;

        // Iterate from the parents of the leaves up to the root.
        // In a 0-indexed perfect binary tree, the last internal node is at index n/2 - 1.
        // The loop iterates from (n/2 - 1) down to 0.
        for i in (0..n / 2).rev() {
            let left_child_idx = 2 * i + 1;
            let right_child_idx = 2 * i + 2;

            // costs[left_child_idx] and costs[right_child_idx] at this point
            // store the maximum path sum from that child node down to any leaf in its subtree,
            // after its own subtree paths have been equalized.
            let sum_from_left_subtree = costs[left_child_idx];
            let sum_from_right_subtree = costs[right_child_idx];

            // To make all paths from the current node 'i' to its leaves equal,
            // the path sums from its children's subtrees must be equal.
            // We choose to make them both equal to the maximum of the two to minimize changes
            // and maximize the path sum propagated upwards, which helps minimize costs overall.
            total_cost += (sum_from_left_subtree - sum_from_right_subtree).abs();

            // Update the current node's cost. This new value represents the maximum
            // path sum from node 'i' down to any leaf in its subtree, considering
            // the equalization of its children's subtrees.
            // This value will then be used by its parent.
            costs[i] += sum_from_left_subtree.max(sum_from_right_subtree);
        }

        total_cost
    }
}