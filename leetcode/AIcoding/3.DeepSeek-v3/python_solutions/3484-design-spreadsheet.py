class Excel:

    def __init__(self, height: int, width: str):
        self.height = height
        self.width = ord(width.upper()) - ord('A') + 1
        self.cells = [[0 for _ in range(self.width)] for _ in range(self.height)]
        self.formulas = {}

    def set(self, row: int, column: str, val: int) -> None:
        r = row - 1
        c = ord(column.upper()) - ord('A')
        self.cells[r][c] = val
        key = (r, c)
        if key in self.formulas:
            del self.formulas[key]

    def get(self, row: int, column: str) -> int:
        r = row - 1
        c = ord(column.upper()) - ord('A')
        key = (r, c)
        if key in self.formulas:
            return self._calculate_formula(key)
        return self.cells[r][c]

    def sum(self, row: int, column: str, numbers: List[str]) -> int:
        r = row - 1
        c = ord(column.upper()) - ord('A')
        key = (r, c)
        self.formulas[key] = numbers
        return self._calculate_formula(key)

    def _calculate_formula(self, key):
        formula = self.formulas[key]
        total = 0
        for part in formula:
            if ':' not in part:
                col = part[0]
                row = int(part[1:])
                total += self.get(row, col)
            else:
                start, end = part.split(':')
                start_col, start_row = start[0], int(start[1:])
                end_col, end_row = end[0], int(end[1:])
                for r in range(start_row, end_row + 1):
                    for c in range(ord(start_col) - ord('A'), ord(end_col) - ord('A') + 1):
                        if (r - 1, c) in self.formulas:
                            total += self._calculate_formula((r - 1, c))
                        else:
                            total += self.cells[r - 1][c]
        return total