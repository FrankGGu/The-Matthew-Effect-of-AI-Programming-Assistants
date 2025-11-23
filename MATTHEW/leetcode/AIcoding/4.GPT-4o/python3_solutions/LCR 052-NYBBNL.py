class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        def inorder(node):
            if node:
                inorder(node.left)
                self.nodes.append(node)
                inorder(node.right)

        self.nodes = []
        inorder(root)
        dummy = TreeNode(0)
        current = dummy

        for node in self.nodes:
            current.right = TreeNode(node.val)
            current = current.right

        return dummy.right