class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sufficientSubset(self, root: TreeNode, limit: int) -> TreeNode:
        def dfs(node, curr_sum):
            if not node:
                return None
            curr_sum += node.val
            if not node.left and not node.right:
                return None if curr_sum < limit else node
            node.left = dfs(node.left, curr_sum)
            node.right = dfs(node.right, curr_sum)
            return node if node.left or node.right else None

        return dfs(root, 0)