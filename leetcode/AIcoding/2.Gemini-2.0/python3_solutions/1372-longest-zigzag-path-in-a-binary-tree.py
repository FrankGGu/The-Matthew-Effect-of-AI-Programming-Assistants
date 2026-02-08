class Solution:
    def longestZigZag(self, root: Optional[TreeNode]) -> int:
        def dfs(node, direction, length):
            if not node:
                return length

            nonlocal max_len
            max_len = max(max_len, length)

            if direction == 'left':
                dfs(node.left, 'right', 1)
                dfs(node.right, 'left', length + 1)
            else:
                dfs(node.right, 'left', 1)
                dfs(node.left, 'right', length + 1)

        max_len = 0
        dfs(root, 'left', 0)
        dfs(root, 'right', 0)

        return max_len