from typing import Optional, List

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def printTree(self, root: Optional[TreeNode]) -> List[List[str]]:
        def get_height(node):
            if not node:
                return 0
            return 1 + max(get_height(node.left), get_height(node.right))

        height = get_height(root)
        width = 2**height - 1
        result = [[""] * width for _ in range(height)]

        def fill_tree(node, row, left, right):
            if not node:
                return
            mid = (left + right) // 2
            result[row][mid] = str(node.val)
            fill_tree(node.left, row + 1, left, mid - 1)
            fill_tree(node.right, row + 1, mid + 1, right)

        fill_tree(root, 0, 0, width - 1)
        return result