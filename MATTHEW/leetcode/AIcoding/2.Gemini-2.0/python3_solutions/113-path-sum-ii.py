class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def pathSum(self, root: TreeNode, targetSum: int) -> list[list[int]]:
        res = []
        def dfs(node, current_sum, path):
            if not node:
                return

            current_sum += node.val
            path.append(node.val)

            if not node.left and not node.right:
                if current_sum == targetSum:
                    res.append(path.copy())
            else:
                dfs(node.left, current_sum, path)
                dfs(node.right, current_sum, path)

            path.pop()

        dfs(root, 0, [])
        return res