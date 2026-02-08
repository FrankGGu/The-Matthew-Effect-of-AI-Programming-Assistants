class Solution:
    def sumOfLeftLeaves(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        total_sum = 0

        if root.left:
            if not root.left.left and not root.left.right:
                total_sum += root.left.val
            else:
                total_sum += self.sumOfLeftLeaves(root.left)

        if root.right:
            total_sum += self.sumOfLeftLeaves(root.right)

        return total_sum