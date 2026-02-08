class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> int:
        from collections import defaultdict

        def dfs(node, current_sum):
            nonlocal count
            if not node:
                return
            current_sum += node.val
            if current_sum == targetSum:
                count += 1
            count += prefix_sums[current_sum - targetSum]
            prefix_sums[current_sum] += 1
            dfs(node.left, current_sum)
            dfs(node.right, current_sum)
            prefix_sums[current_sum] -= 1

        count = 0
        prefix_sums = defaultdict(int)
        dfs(root, 0)
        return count