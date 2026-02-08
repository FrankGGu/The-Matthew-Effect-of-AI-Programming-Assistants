class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isCousins(self, root: TreeNode, x: int, y: int) -> bool:
        if not root:
            return False

        queue = [(root, 0, None)]
        x_info = None
        y_info = None

        while queue:
            next_level = []
            for node, depth, parent in queue:
                if node.val == x:
                    x_info = (depth, parent)
                if node.val == y:
                    y_info = (depth, parent)

                if node.left:
                    next_level.append((node.left, depth + 1, node))
                if node.right:
                    next_level.append((node.right, depth + 1, node))

            if x_info and y_info:
                break

            queue = next_level

        if not x_info or not y_info:
            return False

        return x_info[0] == y_info[0] and x_info[1] != y_info[1]