from typing import Optional

class Solution:
    def decorateTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        MOD = 10**9 + 7

        def dfs(node: Optional[TreeNode]):
            if not node:
                return

            dfs(node.left)
            dfs(node.right)

            left_val = node.left.val if node.left else 0
            right_val = node.right.val if node.right else 0

            node.val = (node.val + left_val + right_val) % MOD

        dfs(root)
        return root