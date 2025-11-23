class Solution:
    def minimumDiameterAfterMerge(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> int:
        def treeDepth(node):
            if not node:
                return 0
            return 1 + max(treeDepth(node.left), treeDepth(node.right))

        def findLongestPath(node):
            if not node:
                return 0
            left = findLongestPath(node.left)
            right = findLongestPath(node.right)
            return 1 + max(left, right)

        def getDiameter(node):
            if not node:
                return 0
            left = treeDepth(node.left)
            right = treeDepth(node.right)
            current = left + right + 1
            leftD = getDiameter(node.left)
            rightD = getDiameter(node.right)
            return max(current, leftD, rightD)

        d1 = getDiameter(root1)
        d2 = getDiameter(root2)
        h1 = treeDepth(root1)
        h2 = treeDepth(root2)
        return max(d1, d2, h1 + h2 + 1)