class Solution:
    def flipMatchVoyage(self, root: Optional[TreeNode], voyage: List[int]) -> List[int]:
        self.flipped = []
        self.index = 0

        def dfs(node):
            if not node:
                return True
            if node.val != voyage[self.index]:
                return False
            self.index += 1
            if node.left and node.left.val != voyage[self.index]:
                self.flipped.append(node.val)
                return dfs(node.right) and dfs(node.left)
            else:
                return dfs(node.left) and dfs(node.right)

        if dfs(root):
            return self.flipped
        else:
            return [-1]