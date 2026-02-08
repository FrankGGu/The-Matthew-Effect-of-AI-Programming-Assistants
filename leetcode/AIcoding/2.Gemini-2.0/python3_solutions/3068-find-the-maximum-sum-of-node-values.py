from typing import List

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def solve():
    def maximum_sum(root: TreeNode) -> int:
        def dfs(node: TreeNode) -> (int, int):
            if not node:
                return 0, 0

            left_with, left_without = dfs(node.left)
            right_with, right_without = dfs(node.right)

            with_node = node.val + left_without + right_without
            without_node = max(left_with, left_without) + max(right_with, right_without)

            return with_node, without_node

        with_root, without_root = dfs(root)
        return max(with_root, without_root)

    return maximum_sum