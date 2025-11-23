class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def maxProduct(self, root: TreeNode) -> int:
        total_sum = self.tree_sum(root)
        sums = []
        self.subtree_sums(root, sums)
        max_product = 0
        for s in sums:
            max_product = max(max_product, s * (total_sum - s))
        return max_product % (10**9 + 7)

    def tree_sum(self, root: TreeNode) -> int:
        if not root:
            return 0
        return root.val + self.tree_sum(root.left) + self.tree_sum(root.right)

    def subtree_sums(self, root: TreeNode, sums: list[int]) -> int:
        if not root:
            return 0
        left_sum = self.subtree_sums(root.left, sums)
        right_sum = self.subtree_sums(root.right, sums)
        subtree_sum = root.val + left_sum + right_sum
        sums.append(subtree_sum)
        return subtree_sum