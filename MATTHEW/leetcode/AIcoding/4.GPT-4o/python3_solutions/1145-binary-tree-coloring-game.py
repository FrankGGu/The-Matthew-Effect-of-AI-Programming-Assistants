class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def btreeGameWinningMove(self, root: TreeNode, n: int, x: int) -> bool:
        self.x_node = None
        self.left_count = 0
        self.right_count = 0

        def dfs(node):
            if not node:
                return 0
            count = 1
            if node.val == x:
                self.x_node = node
            count += dfs(node.left)
            count += dfs(node.right)
            return count

        total_nodes = dfs(root)

        if self.x_node:
            self.left_count = self.x_node.left and self.count_nodes(self.x_node.left) or 0
            self.right_count = self.x_node.right and self.count_nodes(self.x_node.right) or 0

        return max(self.left_count, self.right_count, total_nodes - (self.left_count + self.right_count + 1)) > n // 2

    def count_nodes(self, node):
        if not node:
            return 0
        return 1 + self.count_nodes(node.left) + self.count_nodes(node.right)