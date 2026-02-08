class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sufficientSubset(self, root: TreeNode, limit: int) -> TreeNode:
        def dfs(node, current_sum):
            if not node:
                return False

            if not node.left and not node.right:
                return current_sum + node.val >= limit

            left_sufficient = dfs(node.left, current_sum + node.val) if node.left else False
            right_sufficient = dfs(node.right, current_sum + node.val) if node.right else False

            if not left_sufficient:
                node.left = None
            if not right_sufficient:
                node.right = None

            return left_sufficient or right_sufficient

        if not dfs(root, 0):
            return None
        else:
            return root