class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findMinimumDiameter(self, root1: TreeNode, root2: TreeNode, m: int) -> int:
        def dfs(node):
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            self.diameter = max(self.diameter, left + right)
            return max(left, right) + 1

        self.diameter = 0
        dfs(root1)
        dfs(root2)

        return self.diameter + m