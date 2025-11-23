class Solution:
    def longestUnivaluePath(self, root: TreeNode) -> int:
        self.max_length = 0

        def dfs(node):
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            left = left + 1 if node.left and node.left.val == node.val else 0
            right = right + 1 if node.right and node.right.val == node.val else 0
            self.max_length = max(self.max_length, left + right)
            return max(left, right)

        dfs(root)
        return self.max_length