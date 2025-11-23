class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        def check_height_and_balance(node):
            if not node:
                return 0

            left_height = check_height_and_balance(node.left)
            if left_height == -1:
                return -1

            right_height = check_height_and_balance(node.right)
            if right_height == -1:
                return -1

            if abs(left_height - right_height) > 1:
                return -1

            return 1 + max(left_height, right_height)

        return check_height_and_balance(root) != -1