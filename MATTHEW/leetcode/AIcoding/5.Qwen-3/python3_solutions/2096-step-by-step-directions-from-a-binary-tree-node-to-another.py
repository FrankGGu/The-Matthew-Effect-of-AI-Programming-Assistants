class Solution:
    def getDirections(self, root: TreeNode, startValue: int, endValue: int) -> str:
        def findPath(node, target, path):
            if not node:
                return False
            if node.val == target:
                return True
            if node.left and findPath(node.left, target, path):
                path.append('L')
                return True
            if node.right and findPath(node.right, target, path):
                path.append('R')
                return True
            return False

        pathToStart = []
        pathToEnd = []

        findPath(root, startValue, pathToStart)
        findPath(root, endValue, pathToEnd)

        i = 0
        while i < len(pathToStart) and i < len(pathToEnd) and pathToStart[i] == pathToEnd[i]:
            i += 1

        return 'U' * len(pathToStart[i:]) + ''.join(pathToEnd[i:])