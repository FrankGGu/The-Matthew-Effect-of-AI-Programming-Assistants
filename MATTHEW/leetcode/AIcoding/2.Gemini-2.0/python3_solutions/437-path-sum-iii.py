class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pathSum(self, root: TreeNode, targetSum: int) -> int:
        count = 0
        prefix_sum = {0: 1}

        def dfs(node, current_sum):
            nonlocal count

            if not node:
                return

            current_sum += node.val

            if current_sum - targetSum in prefix_sum:
                count += prefix_sum[current_sum - targetSum]

            prefix_sum[current_sum] = prefix_sum.get(current_sum, 0) + 1

            dfs(node.left, current_sum)
            dfs(node.right, current_sum)

            prefix_sum[current_sum] -= 1

        dfs(root, 0)
        return count