class Solution:
    def invertTree(self, root: TreeNode) -> TreeNode:
        if not root:
            return None
        left = self.invertTree(root.left)
        right = self.invertTree(root.right)
        root.left, root.right = right, left
        return root

    def sumTree(self, root: TreeNode) -> int:
        if not root:
            return 0
        return root.val + self.sumTree(root.left) + self.sumTree(root.right)

    def subtreeInversionSum(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        inverted = self.invertTree(root)
        total = self.sumTree(inverted)
        left_sum = self.subtreeInversionSum(root.left)
        right_sum = self.subtreeInversionSum(root.right)
        return total + left_sum + right_sum