class Solution:
    def longestUnivaluePath(self, root: TreeNode) -> int:
        self.max_len = 0

        def dfs(node):
            if not node:
                return 0

            left_path_len = dfs(node.left)
            right_path_len = dfs(node.right)

            current_left_univalue_path = 0
            if node.left and node.left.val == node.val:
                current_left_univalue_path = 1 + left_path_len

            current_right_univalue_path = 0
            if node.right and node.right.val == node.val:
                current_right_univalue_path = 1 + right_path_len

            self.max_len = max(self.max_len, current_left_univalue_path + current_right_univalue_path)

            return max(current_left_univalue_path, current_right_univalue_path)

        dfs(root)
        return self.max_len