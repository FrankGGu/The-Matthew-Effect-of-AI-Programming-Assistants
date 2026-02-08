class Solution:
    def printTree(self, root: Optional[TreeNode]) -> List[List[str]]:
        def get_height(node):
            if not node:
                return 0
            return 1 + max(get_height(node.left), get_height(node.right))

        height = get_height(root)
        width = (1 << height) - 1
        res = [[""] * width for _ in range(height)]

        def fill(node, row, left, right):
            if not node:
                return
            mid = (left + right) // 2
            res[row][mid] = str(node.val)
            fill(node.left, row + 1, left, mid - 1)
            fill(node.right, row + 1, mid + 1, right)

        fill(root, 0, 0, width - 1)
        return res