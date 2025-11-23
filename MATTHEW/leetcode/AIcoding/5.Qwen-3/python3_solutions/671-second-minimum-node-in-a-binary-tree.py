class Solution:
    def findSecondMinimumNode(self, root: TreeNode) -> int:
        self.min1 = root.val
        self.min2 = float('inf')

        def dfs(node):
            if not node:
                return
            if node.val < self.min2 and node.val > self.min1:
                self.min2 = node.val
            elif node.val == self.min1:
                dfs(node.left)
                dfs(node.right)

        dfs(root)
        return self.min2 if self.min2 != float('inf') else -1