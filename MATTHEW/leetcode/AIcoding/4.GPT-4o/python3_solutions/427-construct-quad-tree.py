class Node:
    def __init__(self, val=True, isLeaf=False, topLeft=None, topRight=None, bottomLeft=None, bottomRight=None):
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight

class Solution:
    def construct(self, grid):
        def isLeaf(x, y, length):
            first = grid[x][y]
            for i in range(x, x + length):
                for j in range(y, y + length):
                    if grid[i][j] != first:
                        return False, None
            return True, first

        def constructQuadTree(x, y, length):
            leaf, value = isLeaf(x, y, length)
            if leaf:
                return Node(value, True)
            half = length // 2
            return Node(
                False,
                False,
                constructQuadTree(x, y, half),
                constructQuadTree(x, y + half, half),
                constructQuadTree(x + half, y, half),
                constructQuadTree(x + half, y + half, half)
            )

        return constructQuadTree(0, 0, len(grid))