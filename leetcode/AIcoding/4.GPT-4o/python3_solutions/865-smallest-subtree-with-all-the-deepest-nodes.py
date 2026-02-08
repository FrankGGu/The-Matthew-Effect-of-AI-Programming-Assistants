class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def subtreeWithAllDeepest(self, root: TreeNode) -> TreeNode:
        def dfs(node):
            if not node:
                return (0, None)
            left_depth, left_node = dfs(node.left)
            right_depth, right_node = dfs(node.right)
            depth = max(left_depth, right_depth) + 1
            if left_depth == right_depth:
                return (depth, node)
            return (depth, left_node if left_depth > right_depth else right_node)

        return dfs(root)[1]