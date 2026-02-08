class Solution:
    def allCellsDistOrder(self, rows: int, cols: int, rCenter: int, cCenter: int) -> list[list[int]]:
        cells = []
        for r in range(rows):
            for c in range(cols):
                cells.append([r, c])

        cells.sort(key=lambda cell: abs(cell[0] - rCenter) + abs(cell[1] - cCenter))

        return cells