class Solution:
    def evaluateTree(self, root: Optional[TreeNode]) -> bool:
        if root.left is None and root.right is None:
            return root.val == 1

        left_result = self.evaluateTree(root.left)
        right_result = self.evaluateTree(root.right)

        if root.val == 2:
            return left_result or right_result
        else:
            return left_result and right_result