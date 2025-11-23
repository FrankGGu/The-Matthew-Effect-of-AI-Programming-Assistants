class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isUnivalTree(self, root: TreeNode) -> bool:
        if not root:
            return True

        val = root.val

        def is_unival(node):
            if not node:
                return True
            if node.val != val:
                return False
            return is_unival(node.left) and is_unival(node.right)

        return is_unival(root)