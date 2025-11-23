class Solution:
    def findMode(self, root: Optional[TreeNode]) -> List[int]:
        self.current_val = None
        self.current_count = 0
        self.max_count = 0
        self.modes = []

        def inorder(node):
            if not node:
                return
            inorder(node.left)
            if node.val == self.current_val:
                self.current_count += 1
            else:
                self.current_val = node.val
                self.current_count = 1
            if self.current_count > self.max_count:
                self.max_count = self.current_count
                self.modes = [self.current_val]
            elif self.current_count == self.max_count:
                self.modes.append(self.current_val)
            inorder(node.right)

        inorder(root)
        return self.modes