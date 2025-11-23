class Solution:
    def countLatticePoints(self, circles: List[List[int]]) -> int:
        s = set()
        for x, y, r in circles:
            for i in range(x - r, x + r + 1):
                for j in range(y - r, y + r + 1):
                    if (i - x) ** 2 + (j - y) ** 2 <= r ** 2:
                        s.add((i, j))
        return len(s)