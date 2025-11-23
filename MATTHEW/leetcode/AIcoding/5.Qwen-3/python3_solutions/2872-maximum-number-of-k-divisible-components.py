class Solution:
    def numberOfComponents(self, root: Optional[TreeNode], k: int) -> int:
        self.count = 0

        def dfs(node):
            if not node:
                return 0
            total = dfs(node.left) + dfs(node.right) + node.val
            if total % k == 0:
                self.count += 1
            return total

        dfs(root)
        return self.count