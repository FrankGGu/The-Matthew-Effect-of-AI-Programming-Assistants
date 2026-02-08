class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def subtreeInversionSum(self, root: TreeNode) -> list[int]:
        res = []

        def dfs(node):
            if not node:
                return 0

            left_sum = dfs(node.left)
            right_sum = dfs(node.right)

            inversion_sum = abs(left_sum - right_sum)
            res.append(inversion_sum)

            return node.val + left_sum + right_sum

        dfs(root)
        return res