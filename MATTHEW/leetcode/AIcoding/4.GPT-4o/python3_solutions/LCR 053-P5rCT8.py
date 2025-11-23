class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def inorderSuccessor(self, root: TreeNode, p: TreeNode) -> TreeNode:
        successor = None

        while root:
            if p.val < root.val:
                successor = root
                root = root.left
            else:
                root = root.right

        return successor