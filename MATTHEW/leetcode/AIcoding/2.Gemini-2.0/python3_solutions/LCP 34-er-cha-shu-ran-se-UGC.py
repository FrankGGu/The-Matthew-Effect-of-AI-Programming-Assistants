class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def btreeGameWinningMove(self, root: TreeNode, n: int, x: int) -> bool:
        self.x_node = None

        def find_x(node):
            if not node:
                return
            if node.val == x:
                self.x_node = node
                return
            find_x(node.left)
            find_x(node.right)

        find_x(root)

        left_size = self.get_size(self.x_node.left)
        right_size = self.get_size(self.x_node.right)
        parent_size = n - left_size - right_size - 1

        return max(left_size, right_size, parent_size) > n // 2

    def get_size(self, node):
        if not node:
            return 0
        return 1 + self.get_size(node.left) + self.get_size(node.right)