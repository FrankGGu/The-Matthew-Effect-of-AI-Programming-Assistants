class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def checkTree(self, root: TreeNode) -> bool:
        if not root:
            return True

        left_val = root.left.val if root.left else 0
        right_val = root.right.val if root.right else 0

        return root.val == left_val + right_val