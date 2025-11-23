class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        def inorder(node):
            if not node:
                return
            inorder(node.left)
            nodes.append(node.val)
            inorder(node.right)

        nodes = []
        inorder(root)

        dummy = TreeNode(0)
        current = dummy
        for val in nodes:
            current.right = TreeNode(val)
            current = current.right

        return dummy.right