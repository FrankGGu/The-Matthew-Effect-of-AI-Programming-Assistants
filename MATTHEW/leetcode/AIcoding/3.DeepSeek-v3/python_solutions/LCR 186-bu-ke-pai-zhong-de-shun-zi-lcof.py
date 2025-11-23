class Solution:
    def canBePlaced(self, positions: List[int]) -> bool:
        positions.sort()
        n = len(positions)
        for i in range(n - 1):
            if positions[i + 1] - positions[i] > 3:
                return False
        return True