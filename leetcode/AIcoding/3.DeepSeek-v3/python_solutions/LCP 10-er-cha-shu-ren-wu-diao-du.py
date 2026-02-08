class Solution:
    def minimalExecTime(self, root: TreeNode) -> float:
        def dfs(node):
            if not node:
                return 0.0, 0.0
            left_total, left_parallel = dfs(node.left)
            right_total, right_parallel = dfs(node.right)
            total = node.val + left_total + right_total
            if left_total < right_total:
                left_total, right_total = right_total, left_total
            if left_total - 2 * left_parallel <= right_total:
                parallel = (left_total + right_total) / 2
            else:
                parallel = right_total + left_parallel
            return total, parallel
        total, parallel = dfs(root)
        return total - parallel