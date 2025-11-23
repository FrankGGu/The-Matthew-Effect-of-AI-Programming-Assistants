class Solution:
    def maxProduct(self, root: TreeNode) -> int:
        def dfs(node):
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            total = left + right + node.val
            self.max_prod = max(self.max_prod, left * (total - left), right * (total - right))
            return total

        self.max_prod = 0
        total = dfs(root)
        return self.max_prod % (10**9 + 7)