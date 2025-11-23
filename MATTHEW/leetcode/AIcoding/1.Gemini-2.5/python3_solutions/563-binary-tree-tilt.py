class Solution:
    def findTilt(self, root: TreeNode) -> int:

        self.total_tilt = 0

        def post_order_sum(node):
            if not node:
                return 0

            left_sum = post_order_sum(node.left)
            right_sum = post_order_sum(node.right)

            self.total_tilt += abs(left_sum - right_sum)

            return left_sum + right_sum + node.val

        post_order_sum(root)
        return self.total_tilt