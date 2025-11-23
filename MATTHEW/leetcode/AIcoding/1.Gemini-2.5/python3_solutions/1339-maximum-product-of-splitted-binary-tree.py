class Solution:
    def maxProduct(self, root: TreeNode) -> int:

        self.total_sum = 0

        def calculate_total_sum_dfs(node):
            if not node:
                return
            self.total_sum += node.val
            calculate_total_sum_dfs(node.left)
            calculate_total_sum_dfs(node.right)

        calculate_total_sum_dfs(root)

        self.max_product = 0
        MOD = 10**9 + 7

        def find_max_product_dfs(node):
            if not node:
                return 0

            left_subtree_sum = find_max_product_dfs(node.left)
            right_subtree_sum = find_max_product_dfs(node.right)

            current_subtree_sum = node.val + left_subtree_sum + right_subtree_sum

            self.max_product = max(self.max_product, current_subtree_sum * (self.total_sum - current_subtree_sum))

            return current_subtree_sum

        find_max_product_dfs(root)

        return self.max_product % MOD