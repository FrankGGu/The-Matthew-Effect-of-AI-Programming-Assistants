class Solution:
    def flatten(self, root: Optional[TreeNode]) -> None:
        """
        Do not return anything, modify root in-place instead.
        """

        self.prev = None

        def _flatten_recursive(node):
            if not node:
                return

            _flatten_recursive(node.right)
            _flatten_recursive(node.left)

            node.right = self.prev
            node.left = None
            self.prev = node

        _flatten_recursive(root)