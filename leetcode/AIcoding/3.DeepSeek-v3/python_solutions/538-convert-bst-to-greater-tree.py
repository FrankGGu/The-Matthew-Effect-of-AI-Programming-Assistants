class Solution:
    def convertBST(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        self.total = 0

        def traverse(node):
            if node:
                traverse(node.right)
                self.total += node.val
                node.val = self.total
                traverse(node.left)

        traverse(root)
        return root