class Solution:
    def rangeSumBST(self, root: Optional[TreeNode], low: int, high: int) -> int:
        if not root:
            return 0
        sum_val = 0
        if low <= root.val <= high:
            sum_val += root.val
        if root.val > low:
            sum_val += self.rangeSumBST(root.left, low, high)
        if root.val < high:
            sum_val += self.rangeSumBST(root.right, low, high)
        return sum_val