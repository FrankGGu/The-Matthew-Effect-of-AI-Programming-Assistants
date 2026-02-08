class Solution:
    def insertIntoMaxTree(self, root: Optional[TreeNode], val: int) -> Optional[TreeNode]:
        if not root or val > root.val:
            new_node = TreeNode(val)
            new_node.left = root
            return new_node
        root.right = self.insertIntoMaxTree(root.right, val)
        return root