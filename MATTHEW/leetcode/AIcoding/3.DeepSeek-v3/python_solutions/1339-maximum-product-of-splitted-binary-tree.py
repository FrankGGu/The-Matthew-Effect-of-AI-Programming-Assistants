class Solution:
    def maxProduct(self, root: Optional[TreeNode]) -> int:
        MOD = 10**9 + 7
        total_sum = 0
        subtree_sums = []

        def calculate_sum(node):
            if not node:
                return 0
            left_sum = calculate_sum(node.left)
            right_sum = calculate_sum(node.right)
            current_sum = left_sum + right_sum + node.val
            subtree_sums.append(current_sum)
            return current_sum

        total_sum = calculate_sum(root)
        max_product = 0
        for s in subtree_sums:
            product = s * (total_sum - s)
            if product > max_product:
                max_product = product

        return max_product % MOD