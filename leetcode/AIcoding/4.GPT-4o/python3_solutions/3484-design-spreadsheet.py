class Spreadsheet:
    def __init__(self):
        self.data = {}

    def set(self, row: int, col: int, value: str) -> None:
        self.data[(row, col)] = value

    def get(self, row: int, col: int) -> str:
        return self.data.get((row, col), "")

    def sum(self, row: int, col: int, ranges: List[str]) -> None:
        total = 0
        for r in ranges:
            start, end = r.split(':')
            start_row, start_col = self._parse_cell(start)
            end_row, end_col = self._parse_cell(end)
            for i in range(start_row, end_row + 1):
                for j in range(start_col, end_col + 1):
                    total += int(self.get(i, j)) if self.get(i, j).isdigit() else 0
        self.set(row, col, str(total))

    def _parse_cell(self, cell: str) -> Tuple[int, int]:
        col = 0
        for char in cell:
            if char.isdigit():
                break
            col = col * 26 + (ord(char) - ord('A') + 1)
        row = int(cell[len(cell) - len(str(int(cell[len(cell) - 1]))):]) )
        return row, col