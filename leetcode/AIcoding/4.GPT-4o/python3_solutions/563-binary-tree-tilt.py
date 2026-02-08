class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findTilt(self, root: TreeNode) -> int:
        self.tilt = 0

        def post_order(node):
            if not node:
                return 0
            left_sum = post_order(node.left)
            right_sum = post_order(node.right)
            self.tilt += abs(left_sum - right_sum)
            return left_sum + right_sum + node.val

        post_order(root)
        return self.tilt