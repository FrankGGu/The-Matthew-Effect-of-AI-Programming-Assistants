class Solution:
    def btreeGameWinningMove(self, root: TreeNode, n: int, x: int) -> bool:
        left_count = 0
        right_count = 0

        def count_nodes(node):
            if not node:
                return 0
            left = count_nodes(node.left)
            right = count_nodes(node.right)
            if node.val == x:
                nonlocal left_count, right_count
                left_count = left
                right_count = right
            return left + right + 1

        count_nodes(root)
        parent_count = n - left_count - right_count - 1
        max_p = max(parent_count, left_count, right_count)
        return max_p > n // 2