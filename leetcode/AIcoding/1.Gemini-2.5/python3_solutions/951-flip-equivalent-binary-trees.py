class Solution:
    def flipEquiv(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> bool:
        if not root1 and not root2:
            return True

        if not root1 or not root2 or root1.val != root2.val:
            return False

        # Option 1: No flip at the current node
        # root1.left matches root2.left AND root1.right matches root2.right
        match_no_flip = self.flipEquiv(root1.left, root2.left) and \
                        self.flipEquiv(root1.right, root2.right)

        # Option 2: Flip at the current node
        # root1.left matches root2.right AND root1.right matches root2.left
        match_with_flip = self.flipEquiv(root1.left, root2.right) and \
                          self.flipEquiv(root1.right, root2.left)

        return match_no_flip or match_with_flip