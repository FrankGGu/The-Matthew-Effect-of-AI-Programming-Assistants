class Solution:
    def kthLargestPerfectSubtreeSize(self, root: Optional[TreeNode], k: int) -> int:
        perfect_sizes = []

        def dfs(node):
            if not node:
                return (0, True)

            left_size, left_perfect = dfs(node.left)
            right_size, right_perfect = dfs(node.right)

            if left_perfect and right_perfect:
                if (not node.left or node.left.val == node.val) and (not node.right or node.right.val == node.val):
                    total_size = 1 + left_size + right_size
                    perfect_sizes.append(total_size)
                    return (total_size, True)

            return (0, False)

        dfs(root)

        if len(perfect_sizes) < k:
            return -1

        perfect_sizes.sort(reverse=True)
        return perfect_sizes[k-1]