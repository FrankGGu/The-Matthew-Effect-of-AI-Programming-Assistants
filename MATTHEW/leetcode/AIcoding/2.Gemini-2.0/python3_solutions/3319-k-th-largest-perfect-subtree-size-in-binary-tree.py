class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def kthLargestPerfectSubtreeSize(self, root: TreeNode, k: int) -> int:
        sizes = []

        def is_perfect(node, height, current_height):
            if not node:
                return current_height == height

            if not node.left and not node.right:
                return current_height == height

            if not node.left or not node.right:
                return False

            return is_perfect(node.left, height, current_height + 1) and is_perfect(node.right, height, current_height + 1)

        def height(node):
            if not node:
                return -1
            return 1 + height(node.left)

        def dfs(node):
            if not node:
                return 0

            left_size = dfs(node.left)
            right_size = dfs(node.right)

            tree_height = height(node)
            if is_perfect(node, tree_height, 0):
                size = (1 << (tree_height + 1)) - 1
                sizes.append(size)
                return size
            else:
                return 0

        dfs(root)
        sizes.sort(reverse=True)

        if k > len(sizes):
            return -1
        else:
            return sizes[k - 1]