class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def kthLargestPerfectSubtreeSize(self, root: TreeNode, k: int) -> int:
        def is_perfect(node):
            if not node:
                return 0
            left_height = is_perfect(node.left)
            right_height = is_perfect(node.right)
            if left_height == -1 or right_height == -1 or left_height != right_height:
                return -1
            return left_height + 1

        sizes = []

        def collect_sizes(node):
            if not node:
                return
            height = is_perfect(node)
            if height != -1:
                sizes.append((height + 1) ** 2)
            collect_sizes(node.left)
            collect_sizes(node.right)

        collect_sizes(root)
        sizes.sort(reverse=True)
        return sizes[k - 1] if k <= len(sizes) else -1