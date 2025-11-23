class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pathSum(self, root: TreeNode, targetSum: int) -> int:
        def dfs(node, prefix_sum):
            nonlocal count
            if not node:
                return

            current_sum = prefix_sum + node.val
            count += prefix_sums.get(current_sum - targetSum, 0)

            prefix_sums[current_sum] = prefix_sums.get(current_sum, 0) + 1

            dfs(node.left, current_sum)
            dfs(node.right, current_sum)

            prefix_sums[current_sum] -= 1

        count = 0
        prefix_sums = {0: 1}
        dfs(root, 0)
        return count