class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def smallestFromLeaf(self, root: TreeNode) -> str:
        self.res = "~"

        def dfs(node, path):
            if not node:
                return
            path = chr(node.val + ord('a')) + path
            if not node.left and not node.right:
                self.res = min(self.res, path)
            dfs(node.left, path)
            dfs(node.right, path)

        dfs(root, "")
        return self.res