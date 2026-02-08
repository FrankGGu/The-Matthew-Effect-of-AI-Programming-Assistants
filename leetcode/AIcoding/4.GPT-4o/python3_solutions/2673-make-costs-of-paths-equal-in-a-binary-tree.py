class Solution:
    def minCost(self, root: Optional[TreeNode]) -> int:
        def dfs(node):
            if not node:
                return (0, 0)
            left_cost, left_count = dfs(node.left)
            right_cost, right_count = dfs(node.right)
            total_count = left_count + right_count + 1
            total_cost = left_cost + right_cost + (left_count + right_count) * node.val
            return total_cost, total_count

        total_cost, total_count = dfs(root)
        return total_cost - total_count * (total_cost // total_count)