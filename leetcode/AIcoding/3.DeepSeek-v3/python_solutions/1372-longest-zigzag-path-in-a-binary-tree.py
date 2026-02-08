class Solution:
    def longestZigZag(self, root: Optional[TreeNode]) -> int:
        self.max_length = 0

        def dfs(node, direction, length):
            if not node:
                return
            self.max_length = max(self.max_length, length)
            if direction == 'left':
                dfs(node.left, 'right', length + 1)
                dfs(node.right, 'left', 1)
            else:
                dfs(node.right, 'left', length + 1)
                dfs(node.left, 'right', 1)

        dfs(root, 'left', 0)
        dfs(root, 'right', 0)
        return self.max_length