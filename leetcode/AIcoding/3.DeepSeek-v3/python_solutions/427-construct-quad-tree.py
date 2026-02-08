"""
class Node:
    def __init__(self, val, isLeaf, topLeft, topRight, bottomLeft, bottomRight):
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
"""

class Solution:
    def construct(self, grid: List[List[int]]) -> 'Node':
        def helper(r1, r2, c1, c2):
            if r1 == r2 and c1 == c2:
                return Node(grid[r1][c1] == 1, True, None, None, None, None)

            allSame = True
            val = grid[r1][c1]
            for i in range(r1, r2 + 1):
                for j in range(c1, c2 + 1):
                    if grid[i][j] != val:
                        allSame = False
                        break
                if not allSame:
                    break

            if allSame:
                return Node(val == 1, True, None, None, None, None)

            rm = (r1 + r2) // 2
            cm = (c1 + c2) // 2
            topLeft = helper(r1, rm, c1, cm)
            topRight = helper(r1, rm, cm + 1, c2)
            bottomLeft = helper(rm + 1, r2, c1, cm)
            bottomRight = helper(rm + 1, r2, cm + 1, c2)
            return Node(False, False, topLeft, topRight, bottomLeft, bottomRight)

        n = len(grid)
        return helper(0, n - 1, 0, n - 1)