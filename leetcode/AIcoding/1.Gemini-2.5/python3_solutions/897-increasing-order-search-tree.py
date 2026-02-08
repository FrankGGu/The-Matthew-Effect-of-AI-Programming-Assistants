class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        dummy = TreeNode(0)
        self.current = dummy

        def inorder(node):
            if not node:
                return

            inorder(node.left)

            self.current.right = node
            node.left = None
            self.current = node

            inorder(node.right)

        inorder(root)
        return dummy.right