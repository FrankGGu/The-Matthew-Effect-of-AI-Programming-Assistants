class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def flipMatchVoyage(self, root: TreeNode, voyage: List[int]) -> List[int]:
        self.index = 0
        self.result = []
        self.success = True

        def dfs(node):
            if not node:
                return
            if node.val != voyage[self.index]:
                self.success = False
                return
            self.index += 1

            if node.left and self.index < len(voyage) and node.left.val != voyage[self.index]:
                self.result.append(node.val)
                node.left, node.right = node.right, node.left

            dfs(node.left)
            dfs(node.right)

        dfs(root)
        return self.result if self.success else [-1]