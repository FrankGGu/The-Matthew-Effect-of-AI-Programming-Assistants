class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> int:
        from collections import defaultdict

        def dfs(node, current_sum):
            if not node:
                return 0
            current_sum += node.val
            count = prefix_sums[current_sum - targetSum]
            prefix_sums[current_sum] += 1
            count += dfs(node.left, current_sum) + dfs(node.right, current_sum)
            prefix_sums[current_sum] -= 1
            return count

        prefix_sums = defaultdict(int)
        prefix_sums[0] = 1
        return dfs(root, 0)