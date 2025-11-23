class Solution:
    def allCellsInDistanceOrder(self, R: int, C: int, X: int, Y: int) -> List[List[int]]:
        cells = []
        for r in range(R):
            for c in range(C):
                cells.append([r, c])
        cells.sort(key=lambda cell: abs(cell[0] - X) + abs(cell[1] - Y))
        return cells