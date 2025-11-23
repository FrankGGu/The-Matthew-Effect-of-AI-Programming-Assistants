class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def printTree(self, root: TreeNode) -> list[list[str]]:
        def get_height(node: TreeNode) -> int:
            if not node:
                return -1
            return 1 + max(get_height(node.left), get_height(node.right))

        height = get_height(root)
        rows = height + 1
        cols = (1 << (height + 1)) - 1

        result_matrix = [[""] * cols for _ in range(rows)]

        def fill_matrix(node: TreeNode, r: int, c: int, current_height: int):
            if not node:
                return

            result_matrix[r][c] = str(node.val)

            offset = 1 << (current_height - r - 1)

            if node.left:
                fill_matrix(node.left, r + 1, c - offset, current_height)
            if node.right:
                fill_matrix(node.right, r + 1, c + offset, current_height)

        fill_matrix(root, 0, (cols - 1) // 2, height)

        return result_matrix