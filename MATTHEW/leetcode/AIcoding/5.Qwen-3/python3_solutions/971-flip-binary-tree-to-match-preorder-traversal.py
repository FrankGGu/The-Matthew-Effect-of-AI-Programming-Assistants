class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def flipMatchVoyage(self, root: TreeNode, voyage: List[int]) -> List[int]:
        self.result = []
        self.index = 0

        def dfs(node):
            if not node:
                return
            if node.val != voyage[self.index]:
                self.result = [-1]
                return
            self.index += 1
            if node.left and node.left.val != voyage[self.index]:
                self.result.append(node.val)
                dfs(node.right)
                dfs(node.left)
            else:
                dfs(node.left)
                dfs(node.right)

        dfs(root)
        return self.result if self.result[0] != -1 else [-1]