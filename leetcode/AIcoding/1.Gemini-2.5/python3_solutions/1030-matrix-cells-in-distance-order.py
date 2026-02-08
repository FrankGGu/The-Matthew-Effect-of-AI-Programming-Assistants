class Solution:
    def allCellsDistOrder(self, R: int, C: int, r0: int, c0: int) -> list[list[int]]:
        cells_with_distance = []
        for r in range(R):
            for c in range(C):
                distance = abs(r - r0) + abs(c - c0)
                cells_with_distance.append((distance, [r, c]))

        cells_with_distance.sort()

        result = [cell for distance, cell in cells_with_distance]
        return result