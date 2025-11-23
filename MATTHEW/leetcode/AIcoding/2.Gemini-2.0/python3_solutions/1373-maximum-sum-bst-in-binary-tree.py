class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def maxSumBST(self, root: TreeNode) -> int:
        max_sum = 0

        def dfs(node):
            nonlocal max_sum
            if not node:
                return float('inf'), float('-inf'), 0, True

            left_min, left_max, left_sum, left_bst = dfs(node.left)
            right_min, right_max, right_sum, right_bst = dfs(node.right)

            if left_bst and right_bst and left_max < node.val < right_min:
                current_sum = left_sum + right_sum + node.val
                max_sum = max(max_sum, current_sum)
                current_min = min(node.val, left_min)
                current_max = max(node.val, right_max)
                return current_min, current_max, current_sum, True
            else:
                return float('-inf'), float('inf'), 0, False

        dfs(root)
        return max_sum