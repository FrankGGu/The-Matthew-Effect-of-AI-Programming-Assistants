class Solution:
    def numberOfWeeks(self, s: List[TreeNode]) -> int:
        def dfs(node):
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            if left == 0 and right == 0:
                return 1
            if left == 0 or right == 0:
                return left + right + 1
            return left + right + 1

        return dfs(s)