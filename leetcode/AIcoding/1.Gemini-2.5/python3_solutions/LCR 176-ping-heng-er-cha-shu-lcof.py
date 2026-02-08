class Solution:
    def isBalanced(self, root: TreeNode) -> bool:
        def check_balance_and_height(node):
            if not node:
                return True, 0

            left_balanced, left_height = check_balance_and_height(node.left)
            right_balanced, right_height = check_balance_and_height(node.right)

            current_node_balanced = (
                left_balanced
                and right_balanced
                and abs(left_height - right_height) <= 1
            )
            current_node_height = 1 + max(left_height, right_height)

            return current_node_balanced, current_node_height

        is_balanced, _ = check_balance_and_height(root)
        return is_balanced