class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findTarget(self, root: TreeNode, k: int) -> bool:
        values = set()

        def inorder(node):
            if not node:
                return False
            if inorder(node.left):
                return True
            if (k - node.val) in values:
                return True
            values.add(node.val)
            return inorder(node.right)

        return inorder(root)