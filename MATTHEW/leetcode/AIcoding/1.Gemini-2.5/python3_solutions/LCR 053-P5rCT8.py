class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def inorderSuccessor(self, root: TreeNode, p: TreeNode) -> TreeNode:
        successor = None
        current = root

        while current:
            if current.val <= p.val:
                current = current.right
            else:
                successor = current
                current = current.left
        return successor