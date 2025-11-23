class Solution:
    def sumNumbers(self, root: Optional[TreeNode]) -> int:
        total_sum = 0

        def dfs(node, current_path_number):
            nonlocal total_sum
            if not node:
                return

            current_path_number = current_path_number * 10 + node.val

            if not node.left and not node.right:
                total_sum += current_path_number
                return

            dfs(node.left, current_path_number)
            dfs(node.right, current_path_number)

        dfs(root, 0)
        return total_sum