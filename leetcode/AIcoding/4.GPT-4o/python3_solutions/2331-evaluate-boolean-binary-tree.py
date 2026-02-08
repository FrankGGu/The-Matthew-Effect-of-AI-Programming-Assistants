class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def evaluateTree(self, root: TreeNode) -> bool:
        if root.val == 1:
            return True
        if root.val == 0:
            return False
        left_eval = self.evaluateTree(root.left)
        right_eval = self.evaluateTree(root.right)
        return left_eval or right_eval if root.val == 2 else left_eval and right_eval