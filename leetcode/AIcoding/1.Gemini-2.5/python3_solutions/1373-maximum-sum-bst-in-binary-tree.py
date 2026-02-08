class Solution:
    def maxSumBST(self, root: TreeNode) -> int:
        self.max_sum = 0

        # This helper function returns a tuple:
        # (is_bst, min_val_in_subtree, max_val_in_subtree, sum_of_subtree_nodes)
        # If is_bst is False, min_val and max_val might not be meaningful for BST checks
        # but they still represent the true min/max of the *entire* subtree for parent's min/max calculation.
        def dfs(node):
            if not node:
                # An empty tree is considered a BST.
                # Its min_val is float('inf') and max_val is float('-inf')
                # to satisfy BST conditions for its parent (any node.val will be > -inf and < inf).
                # Its sum is 0.
                return True, float('inf'), float('-inf'), 0

            left_is_bst, left_min, left_max, left_sum = dfs(node.left)
            right_is_bst, right_min, right_max, right_sum = dfs(node.right)

            # Check if the current subtree rooted at 'node' forms a valid BST
            current_is_bst = False
            if left_is_bst and right_is_bst and \
               node.val > left_max and node.val < right_min:
                current_is_bst = True

            # Calculate the overall min, max, and sum for the current subtree
            # regardless of whether it's a BST or not.
            # These values are needed for its parent's BST check and sum calculation.
            current_min = min(node.val, left_min, right_min)
            current_max = max(node.val, left_max, right_max)
            current_total_sum = node.val + left_sum + right_sum

            # If the current subtree is a BST, update the global maximum sum found so far
            if current_is_bst:
                self.max_sum = max(self.max_sum, current_total_sum)

            return current_is_bst, current_min, current_max, current_total_sum

        dfs(root)
        return self.max_sum