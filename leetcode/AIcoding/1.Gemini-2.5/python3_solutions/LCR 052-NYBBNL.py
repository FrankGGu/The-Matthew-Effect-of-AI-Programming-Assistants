class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        dummy = TreeNode(0)
        self.current = dummy

        def inorder_traverse(node):
            if not node:
                return

            inorder_traverse(node.left)

            node.left = None
            self.current.right = node
            self.current = node

            inorder_traverse(node.right)

        inorder_traverse(root)
        return dummy.right