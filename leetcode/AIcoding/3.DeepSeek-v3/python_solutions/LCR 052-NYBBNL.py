class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        def inorder(node):
            if not node:
                return []
            return inorder(node.left) + [node.val] + inorder(node.right)

        values = inorder(root)
        dummy = TreeNode()
        current = dummy
        for val in values:
            current.right = TreeNode(val)
            current = current.right
        return dummy.right