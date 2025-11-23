class Solution:
    def printTree(self, root: TreeNode) -> List[List[str]]:
        def getHeight(node):
            if not node:
                return -1
            return 1 + max(getHeight(node.left), getHeight(node.right))

        def buildTree(node, depth, left, right, result):
            if not node:
                return
            mid = (left + right) // 2
            result[depth][mid] = str(node.val)
            buildTree(node.left, depth + 1, left, mid - 1, result)
            buildTree(node.right, depth + 1, mid + 1, right, result)

        height = getHeight(root)
        rows = height + 1
        cols = 2 ** (height + 1) - 1
        result = [['' for _ in range(cols)] for _ in range(rows)]
        buildTree(root, 0, 0, cols - 1, result)
        return result