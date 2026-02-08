class Solution:
    def countLatticePoints(self, r: int) -> int:
        count = 0
        for x in range(-r, r + 1):
            y_limit = int((r**2 - x**2)**0.5)
            count += y_limit * 2 + 1
        return count