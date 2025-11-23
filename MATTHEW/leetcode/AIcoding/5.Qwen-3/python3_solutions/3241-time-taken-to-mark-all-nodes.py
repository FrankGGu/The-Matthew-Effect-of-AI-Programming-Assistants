class Solution:
    def timeTaken(self, root: Optional[TreeNode]) -> int:
        def dfs(node):
            if not node:
                return 0, 0
            left_time, left_depth = dfs(node.left)
            right_time, right_depth = dfs(node.right)
            return max(left_time, right_time) + 1, max(left_depth, right_depth) + 1

        time, _ = dfs(root)
        return time