class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def maxProduct(self, root: TreeNode) -> int:
        total = self.sum_tree(root)
        self.max_product = 0

        def split_tree(node):
            if not node:
                return 0
            left_sum = split_tree(node.left)
            right_sum = split_tree(node.right)
            current_sum = left_sum + right_sum + node.val
            self.max_product = max(self.max_product, current_sum * (total - current_sum))
            return current_sum

        split_tree(root)
        return self.max_product % (10**9 + 7)

    def sum_tree(self, node):
        if not node:
            return 0
        return node.val + self.sum_tree(node.left) + self.sum_tree(node.right)