class Solution:
    def expandBinaryTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return None

        if root.left:
            new_left = TreeNode(-1, left=self.expandBinaryTree(root.left))
            root.left = new_left

        if root.right:
            new_right = TreeNode(-1, right=self.expandBinaryTree(root.right))
            root.right = new_right

        return root