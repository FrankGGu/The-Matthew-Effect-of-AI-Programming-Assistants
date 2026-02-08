class Solution:
    def isPrintable(self, targetGrid: List[List[int]]) -> bool:
        def canPrint(color):
            if color in printed:
                return True
            if color not in bounds:
                return False

            left, right, top, bottom = bounds[color]
            for i in range(top, bottom + 1):
                for j in range(left, right + 1):
                    if targetGrid[i][j] != color:
                        return False
            for i in range(top, bottom + 1):
                for j in range(left, right + 1):
                    targetGrid[i][j] = -1
            printed.add(color)
            return True

        colors = set()
        bounds = {}
        for i in range(len(targetGrid)):
            for j in range(len(targetGrid[0])):
                color = targetGrid[i][j]
                colors.add(color)
                if color == -1:
                    continue
                if color not in bounds:
                    bounds[color] = [j, j, i, i]
                bounds[color][0] = min(bounds[color][0], j)
                bounds[color][1] = max(bounds[color][1], j)
                bounds[color][2] = min(bounds[color][2], i)
                bounds[color][3] = max(bounds[color][3], i)

        printed = set()
        while colors:
            color = colors.pop()
            if color != -1 and not canPrint(color):
                return False
        return True