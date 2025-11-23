class Solution:
    def averageOfSubtree(self, root: Optional[TreeNode]) -> int:
        self.count = 0

        def dfs(node):
            if not node:
                return 0, 0  # (sum_of_nodes, count_of_nodes)

            left_sum, left_count = dfs(node.left)
            right_sum, right_count = dfs(node.right)

            current_sum = node.val + left_sum + right_sum
            current_count = 1 + left_count + right_count

            if node.val == (current_sum // current_count):
                self.count += 1

            return current_sum, current_count

        dfs(root)
        return self.count