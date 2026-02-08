from typing import Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def _dfs(self, node: Optional[TreeNode]) -> tuple[int, int]:
        if not node:
            return (0, 0)

        left_val_if_not_taken, left_val_if_taken = self._dfs(node.left)
        right_val_if_not_taken, right_val_if_taken = self._dfs(node.right)

        val_if_not_taken = max(left_val_if_not_taken, left_val_if_taken) + \
                           max(right_val_if_not_taken, right_val_if_taken)

        val_if_taken = node.val + left_val_if_not_taken + right_val_if_not_taken

        return (val_if_not_taken, val_if_taken)

    def solve(self, root: Optional[TreeNode]) -> int:
        val_if_root_not_taken, val_if_root_taken = self._dfs(root)
        return max(val_if_root_not_taken, val_if_root_taken)