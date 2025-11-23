class Solution:
    def bstToGst(self, root: TreeNode) -> TreeNode:
        self.total = 0

        def reverse_inorder(node):
            if node:
                reverse_inorder(node.right)
                self.total += node.val
                node.val = self.total
                reverse_inorder(node.left)

        reverse_inorder(root)
        return root