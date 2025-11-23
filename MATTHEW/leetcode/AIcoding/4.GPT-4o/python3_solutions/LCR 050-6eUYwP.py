class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pathSum(self, root: TreeNode, targetSum: int) -> int:
        def dfs(node, current_sum):
            if not node:
                return 0
            current_sum += node.val
            return (current_sum == targetSum) + dfs(node.left, current_sum) + dfs(node.right, current_sum)

        if not root:
            return 0

        return dfs(root, 0) + self.pathSum(root.left, targetSum) + self.pathSum(root.right, targetSum)