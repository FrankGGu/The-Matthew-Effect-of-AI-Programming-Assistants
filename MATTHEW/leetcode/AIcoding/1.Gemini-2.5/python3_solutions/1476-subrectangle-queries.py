class SubrectangleQueries:

    def __init__(self, rectangle: list[list[int]]):
        self.rect = rectangle

    def updateSubrectangle(self, row1: int, col1: int, row2: int, col2: int, newValue: int) -> None:
        for r in range(row1, row2 + 1):
            for c in range(col1, col2 + 1):
                self.rect[r][c] = newValue

    def getValue(self, row: int, col: int) -> int:
        return self.rect[row][col]