import math

class Solution:
    def minDiffInBST(self, root: Optional[TreeNode]) -> int:
        self.min_diff = math.inf
        self.prev_val = None

        def inorder(node):
            if not node:
                return

            inorder(node.left)

            if self.prev_val is not None:
                self.min_diff = min(self.min_diff, node.val - self.prev_val)
            self.prev_val = node.val

            inorder(node.right)

        inorder(root)
        return self.min_diff