class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def addOneRow(self, root: TreeNode, val: int, depth: int) -> TreeNode:
        if depth == 1:
            return TreeNode(val, root, None)

        def add_row(node, current_depth):
            if not node:
                return
            if current_depth == depth - 1:
                node.left = TreeNode(val, node.left, None)
                node.right = TreeNode(val, None, node.right)
            else:
                add_row(node.left, current_depth + 1)
                add_row(node.right, current_depth + 1)

        add_row(root, 1)
        return root