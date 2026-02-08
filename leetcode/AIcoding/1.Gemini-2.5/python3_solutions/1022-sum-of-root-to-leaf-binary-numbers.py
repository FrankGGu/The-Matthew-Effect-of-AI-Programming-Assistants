class Solution:
    def sumRootToLeaf(self, root: TreeNode) -> int:
        total_sum = 0

        def dfs(node, current_binary_number):
            nonlocal total_sum
            if not node:
                return

            current_binary_number = (current_binary_number << 1) | node.val

            if not node.left and not node.right:
                total_sum += current_binary_number
                return

            dfs(node.left, current_binary_number)
            dfs(node.right, current_binary_number)

        dfs(root, 0)
        return total_sum