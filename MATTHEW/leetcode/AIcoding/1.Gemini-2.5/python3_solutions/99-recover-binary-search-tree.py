class Solution:
    def recoverTree(self, root: Optional[TreeNode]) -> None:
        self.first = None
        self.second = None
        self.prev = None

        self._inorder_traverse(root)

        if self.first and self.second:
            self.first.val, self.second.val = self.second.val, self.first.val

    def _inorder_traverse(self, node: Optional[TreeNode]) -> None:
        if not node:
            return

        self._inorder_traverse(node.left)

        if self.prev and node.val < self.prev.val:
            if not self.first:
                self.first = self.prev
            self.second = node

        self.prev = node

        self._inorder_traverse(node.right)