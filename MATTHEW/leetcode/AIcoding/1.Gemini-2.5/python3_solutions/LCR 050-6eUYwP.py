class Solution:
    def pathSum(self, root: TreeNode, targetSum: int) -> int:
        self.count = 0
        self.prefix_sums = {0: 1}

        def dfs(node, current_sum):
            if not node:
                return

            current_sum += node.val

            # Check if there's a prefix sum that makes the current path sum to targetSum
            # i.e., current_sum - targetSum
            if (current_sum - targetSum) in self.prefix_sums:
                self.count += self.prefix_sums[current_sum - targetSum]

            # Add the current_sum to the prefix_sums map
            self.prefix_sums[current_sum] = self.prefix_sums.get(current_sum, 0) + 1

            # Recurse on children
            dfs(node.left, current_sum)
            dfs(node.right, current_sum)

            # Backtrack: Remove the current_sum from the map when moving up
            # This is crucial because paths must go downwards, so a sum is only valid
            # for its own subtree, not for sibling subtrees.
            self.prefix_sums[current_sum] -= 1
            if self.prefix_sums[current_sum] == 0:
                del self.prefix_sums[current_sum]

        dfs(root, 0)
        return self.count