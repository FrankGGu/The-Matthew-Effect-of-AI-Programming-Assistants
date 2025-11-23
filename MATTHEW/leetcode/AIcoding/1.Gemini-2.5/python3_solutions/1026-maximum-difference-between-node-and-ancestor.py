from typing import Optional

class Solution:
    def maxAncestorDiff(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        self.max_diff = 0

        def dfs(node, min_val_ancestor, max_val_ancestor):
            if not node:
                return

            self.max_diff = max(self.max_diff, abs(node.val - min_val_ancestor))
            self.max_diff = max(self.max_diff, abs(node.val - max_val_ancestor))

            new_min_val_ancestor = min(min_val_ancestor, node.val)
            new_max_val_ancestor = max(max_val_ancestor, node.val)

            dfs(node.left, new_min_val_ancestor, new_max_val_ancestor)
            dfs(node.right, new_min_val_ancestor, new_max_val_ancestor)

        dfs(root, root.val, root.val)

        return self.max_diff