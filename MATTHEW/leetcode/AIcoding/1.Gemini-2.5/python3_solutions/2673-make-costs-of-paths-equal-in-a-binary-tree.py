from typing import List

class Solution:
    def makeCostsEqual(self, costs: List[int]) -> int:
        self.ans = 0
        n = len(costs)

        def dfs(node_idx: int) -> int:
            # If the node_idx is out of bounds, it means this path does not exist.
            # We treat its path sum as 0. This will be compared with its sibling's path sum,
            # and any difference will be added to self.ans, effectively "incrementing" this non-existent path.
            if node_idx >= n:
                return 0

            # If it's a leaf node (no left child means no children in a complete binary tree represented by an array).
            # The condition 2 * node_idx + 1 >= n checks if the left child's index is out of bounds.
            if 2 * node_idx + 1 >= n:
                return costs[node_idx]

            # Recursively calculate the maximum path sum from the left child to a leaf in its subtree.
            left_max_path = dfs(2 * node_idx + 1)
            # Recursively calculate the maximum path sum from the right child to a leaf in its subtree.
            right_max_path = dfs(2 * node_idx + 2)

            # To make the paths from the children equal, we must increment the smaller path
            # to match the larger path. The cost of this increment is the absolute difference.
            self.ans += abs(left_max_path - right_max_path)

            # The maximum path sum from the current node to a leaf in its subtree
            # is its own cost plus the maximum of the (now equalized) path sums from its children.
            return costs[node_idx] + max(left_max_path, right_max_path)

        # Start the DFS from the root node (index 0).
        dfs(0)
        return self.ans