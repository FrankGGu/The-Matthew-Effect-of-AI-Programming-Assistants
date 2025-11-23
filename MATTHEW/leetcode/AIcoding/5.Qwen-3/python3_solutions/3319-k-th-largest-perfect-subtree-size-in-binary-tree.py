class Solution:
    def kthLargestPerfectSubtreeSize(self, root: Optional[TreeNode], k: int) -> int:
        from collections import defaultdict

        def dfs(node):
            if not node:
                return 0
            left = dfs(node.left)
            right = dfs(node.right)
            if left == right and left != -1:
                size = left + right + 1
                count[size] += 1
                return size
            else:
                return -1

        count = defaultdict(int)
        dfs(root)
        sorted_sizes = sorted(count.keys(), reverse=True)
        for size in sorted_sizes:
            if k <= count[size]:
                return size
            else:
                k -= count[size]
        return -1