class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sumEvenGrandparent(self, root: TreeNode) -> int:
        def dfs(node, parent_val, grandparent_val):
            if not node:
                return 0
            sum_ = 0
            if grandparent_val % 2 == 0:
                sum_ += node.val
            sum_ += dfs(node.left, node.val, parent_val) 
            sum_ += dfs(node.right, node.val, parent_val)
            return sum_

        return dfs(root, 1, 1)