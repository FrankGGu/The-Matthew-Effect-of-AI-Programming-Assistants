class Solution:
    def flatten(self, root: TreeNode) -> None:
        if not root:
            return
        self.flatten(root.left)
        self.flatten(root.right)
        if root.left:
            temp = root.right
            root.right = root.left
            root.left = None
            while root.right:
                root = root.right
            root.right = temp