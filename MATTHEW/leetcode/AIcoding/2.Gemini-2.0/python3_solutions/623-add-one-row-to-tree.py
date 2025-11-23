class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def addOneRow(self, root: TreeNode, val: int, depth: int) -> TreeNode:
        if depth == 1:
            new_root = TreeNode(val)
            new_root.left = root
            return new_root

        def dfs(node, d):
            if not node:
                return

            if d == depth - 1:
                temp_left = node.left
                temp_right = node.right

                node.left = TreeNode(val)
                node.right = TreeNode(val)

                node.left.left = temp_left
                node.right.right = temp_right
                return

            dfs(node.left, d + 1)
            dfs(node.right, d + 1)

        dfs(root, 1)
        return root