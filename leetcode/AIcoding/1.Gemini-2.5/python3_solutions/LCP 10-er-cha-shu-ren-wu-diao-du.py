import math
from typing import Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def maxPathSum(self, root: Optional[TreeNode]) -> int:
        self.max_sum = -math.inf

        def max_gain(node):
            if not node:
                return 0

            left_gain = max(0, max_gain(node.left))
            right_gain = max(0, max_gain(node.right))

            price_newpath = node.val + left_gain + right_gain
            self.max_sum = max(self.max_sum, price_newpath)

            return node.val + max(left_gain, right_gain)

        max_gain(root)
        return self.max_sum