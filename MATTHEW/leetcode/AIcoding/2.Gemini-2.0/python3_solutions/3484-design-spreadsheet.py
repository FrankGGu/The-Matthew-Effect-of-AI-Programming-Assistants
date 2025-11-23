class Spreadsheet:

    def __init__(self, rows: int, cols: int):
        self.rows = rows
        self.cols = cols
        self.grid = [['' for _ in range(cols)] for _ in range(rows)]
        self.formula_cache = {}

    def set_value(self, row: int, col: int, val: int) -> None:
        self.grid[row][col] = val
        self.formula_cache = {}

    def get_value(self, row: int, col: int) -> int:
        cell = self.grid[row][col]
        if isinstance(cell, int):
            return cell
        elif cell == '':
            return 0
        else:
            return self.evaluate_formula(row, col)

    def set_formula(self, row: int, col: int, formula: List[str]) -> None:
        self.grid[row][col] = formula
        self.formula_cache = {}

    def evaluate_formula(self, row: int, col: int) -> int:
        if (row, col) in self.formula_cache:
            return self.formula_cache[(row, col)]

        formula = self.grid[row][col]
        total = 0
        for cell_formula in formula:
            parts = cell_formula.split()
            r1, c1 = self.parse_cell_name(parts[0])
            if len(parts) == 1:
                total += self.get_value(r1, c1)
            else:
                r2, c2 = self.parse_cell_name(parts[2])
                for r in range(r1, r2 + 1):
                    for c in range(c1, c2 + 1):
                        total += self.get_value(r, c)
        self.formula_cache[(row, col)] = total
        return total

    def parse_cell_name(self, cell_name: str) -> Tuple[int, int]:
        col = 0
        for char in cell_name:
            if char.isalpha():
                col = col * 26 + (ord(char) - ord('A') + 1)
            else:
                break
        row = int(cell_name[len(str(col)):]) - 1
        return row, col - 1