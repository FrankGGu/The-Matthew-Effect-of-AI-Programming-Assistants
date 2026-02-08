class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findTilt(self, root: TreeNode) -> int:
        self.tilt_sum = 0

        def subtree_sum(node):
            if not node:
                return 0
            left_sum = subtree_sum(node.left)
            right_sum = subtree_sum(node.right)
            self.tilt_sum += abs(left_sum - right_sum)
            return node.val + left_sum + right_sum

        subtree_sum(root)
        return self.tilt_sum