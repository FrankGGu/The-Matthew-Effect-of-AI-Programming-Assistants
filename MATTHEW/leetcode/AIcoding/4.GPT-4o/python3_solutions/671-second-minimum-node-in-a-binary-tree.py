class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def findSecondMinimumValue(self, root: TreeNode) -> int:
        self.first = float('inf')
        self.second = float('inf')

        def dfs(node):
            if not node:
                return
            if node.val < self.first:
                self.second = self.first
                self.first = node.val
            elif self.first < node.val < self.second:
                self.second = node.val
            dfs(node.left)
            dfs(node.right)

        dfs(root)
        return self.second if self.second < float('inf') else -1