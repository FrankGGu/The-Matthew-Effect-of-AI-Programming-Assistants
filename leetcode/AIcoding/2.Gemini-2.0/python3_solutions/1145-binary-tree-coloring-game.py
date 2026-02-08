class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def btreeGameWinningMove(self, root: TreeNode, n: int, x: int) -> bool:
        self.left_count = 0
        self.right_count = 0
        self.x_node = None

        def count_nodes(node: TreeNode, x: int) -> int:
            if not node:
                return 0

            left = count_nodes(node.left, x)
            right = count_nodes(node.right, x)

            if node.val == x:
                self.x_node = node
                self.left_count = left
                self.right_count = right

            return left + right + 1

        count_nodes(root, x)

        parent_count = n - self.left_count - self.right_count - 1

        return max(parent_count, self.left_count, self.right_count) > n // 2