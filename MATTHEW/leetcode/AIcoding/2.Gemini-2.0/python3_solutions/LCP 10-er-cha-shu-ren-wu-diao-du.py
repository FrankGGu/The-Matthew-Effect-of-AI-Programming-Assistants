class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def treeScheduling(self, root: TreeNode) -> int:
        def rob(node):
            if not node:
                return 0, 0

            left_with, left_without = rob(node.left)
            right_with, right_without = rob(node.right)

            with_node = node.val + left_without + right_without
            without_node = max(left_with, left_without) + max(right_with, right_without)

            return with_node, without_node

        with_root, without_root = rob(root)
        return max(with_root, without_root)