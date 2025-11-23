class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isCousins(self, root: TreeNode, x: int, y: int) -> bool:
        def dfs(node, val, depth, parent):
            if not node:
                return None
            if node.val == val:
                return (depth, parent)
            left = dfs(node.left, val, depth + 1, node)
            if left:
                return left
            return dfs(node.right, val, depth + 1, node)

        x_info = dfs(root, x, 0, None)
        y_info = dfs(root, y, 0, None)

        return (x_info[0] == y_info[0]) and (x_info[1] != y_info[1])