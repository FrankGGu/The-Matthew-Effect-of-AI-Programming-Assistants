class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def printTree(self, root: TreeNode) -> List[List[str]]:
        def height(node):
            if not node:
                return 0
            return 1 + max(height(node.left), height(node.right))

        h = height(root)
        res = [[""] * (2 ** h - 1) for _ in range(h)]

        def fill(node, r, c, depth):
            if not node:
                return
            res[depth][c] = str(node.val)
            fill(node.left, r + 1, c - 2 ** (h - r - 1), depth + 1)
            fill(node.right, r + 1, c + 2 ** (h - r - 1), depth + 1)

        fill(root, 0, (2 ** h - 1) // 2, 0)
        return res