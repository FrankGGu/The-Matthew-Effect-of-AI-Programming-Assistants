class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isUnivalTree(self, root: TreeNode) -> bool:
        def check(node, value):
            if not node:
                return True
            return node.val == value and check(node.left, value) and check(node.right, value)

        return check(root, root.val) if root else True