class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def convertBST(self, root: TreeNode) -> TreeNode:
        self.sum = 0
        def dfs(node):
            if not node:
                return
            dfs(node.right)
            self.sum += node.val
            node.val = self.sum
            dfs(node.left)
        dfs(root)
        return root