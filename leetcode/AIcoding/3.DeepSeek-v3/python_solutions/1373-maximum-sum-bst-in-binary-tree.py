class Solution:
    def maxSumBST(self, root: Optional[TreeNode]) -> int:
        self.max_sum = 0

        def dfs(node):
            if not node:
                return (True, float('inf'), float('-inf'), 0)

            left_is_bst, left_min, left_max, left_sum = dfs(node.left)
            right_is_bst, right_min, right_max, right_sum = dfs(node.right)

            if left_is_bst and right_is_bst and left_max < node.val < right_min:
                current_sum = left_sum + right_sum + node.val
                self.max_sum = max(self.max_sum, current_sum)
                current_min = min(left_min, node.val)
                current_max = max(right_max, node.val)
                return (True, current_min, current_max, current_sum)
            else:
                return (False, 0, 0, 0)

        dfs(root)
        return self.max_sum