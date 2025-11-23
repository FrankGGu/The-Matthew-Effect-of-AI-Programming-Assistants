class Solution:
    def longestUnivaluePath(self, root: TreeNode) -> int:
        self.ans = 0

        def dfs(node):
            if not node:
                return 0
            left_length = dfs(node.left)
            right_length = dfs(node.right)
            left_arrow = right_arrow = 0
            if node.left and node.left.val == node.val:
                left_arrow = left_length + 1
            if node.right and node.right.val == node.val:
                right_arrow = right_length + 1
            self.ans = max(self.ans, left_arrow + right_arrow)
            return max(left_arrow, right_arrow)

        dfs(root)
        return self.ans