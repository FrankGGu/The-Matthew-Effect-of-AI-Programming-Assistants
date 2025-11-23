class Solution:
    def collectCoins(self, root: Optional[TreeNode]) -> int:
        def dfs(node):
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            if left == 0 and right == 0:
                return 1
            if left == 0:
                return right + 1
            if right == 0:
                return left + 1
            return min(left, right) + 1

        def count(node, depth):
            if not node:
                return 0
            if depth == 0:
                return 0
            return count(node.left, depth - 1) + count(node.right, depth - 1) + (1 if depth == 1 else 0)

        depth = dfs(root)
        return max(0, count(root, depth - 1))