from typing import Optional

class Solution:
    def distributeCoins(self, root: Optional[TreeNode]) -> int:
        self.moves = 0

        def dfs(node):
            if not node:
                return 0

            left_excess = dfs(node.left)
            right_excess = dfs(node.right)

            self.moves += abs(left_excess)
            self.moves += abs(right_excess)

            return node.val - 1 + left_excess + right_excess

        dfs(root)
        return self.moves