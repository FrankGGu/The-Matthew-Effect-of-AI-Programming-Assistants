class Solution:
    def getMinimumDifference(self, root: Optional[TreeNode]) -> int:
        self.prev_val = None
        self.min_diff = float('inf')

        def inorder_traverse(node):
            if not node:
                return

            inorder_traverse(node.left)

            if self.prev_val is not None:
                self.min_diff = min(self.min_diff, node.val - self.prev_val)
            self.prev_val = node.val

            inorder_traverse(node.right)

        inorder_traverse(root)
        return int(self.min_diff)