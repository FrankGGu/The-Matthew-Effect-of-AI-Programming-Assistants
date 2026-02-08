class Spreadsheet:

    def __init__(self, rows: int, cols: int):
        self.rows = rows
        self.cols = cols
        self.grid = [['0'] * cols for _ in range(rows)]
        self.values = [[0] * cols for _ in range(rows)]

    def _parse_cell_ref(self, s: str) -> tuple[int, int]:
        col_idx = ord(s[0]) - ord('A')
        row_idx = int(s[1:]) - 1
        return row_idx, col_idx

    def _parse_range_ref(self, s: str) -> tuple[int, int, int, int]:
        parts = s.split(':')
        r1, c1 = self._parse_cell_ref(parts[0])
        r2, c2 = self._parse_cell_ref(parts[1])
        return r1, c1, r2, c2

    def set(self, r: int, c: int, expr: str) -> None:
        r_idx, c_idx = r - 1, c - 1
        self.grid[r_idx][c_idx] = expr
        self.values[r_idx][c_idx] = 0

    def get(self, r: int, c: int) -> int:
        r_idx, c_idx = r - 1, c - 1
        return self._eval_cell(r_idx, c_idx, set())

    def _eval_cell(self, r_idx: int, c_idx: int, visiting_cells: set[tuple[int, int]]) -> int:
        if (r_idx, c_idx) in visiting_cells:
            return self.values[r_idx][c_idx]

        visiting_cells.add((r_idx, c_idx))

        expr = self.grid[r_idx][c_idx]
        current_value = 0

        if expr.startswith('='):
            formula = expr[1:]
            if formula.startswith('SUM(') and formula.endswith(')'):
                range_str = formula[4:-1]
                r1, c1, r2, c2 = self._parse_range_ref(range_str)

                r_start, r_end = min(r1, r2), max(r1, r2)
                c_start, c_end = min(c1, c2), max(c1, c2)

                for r_iter in range(r_start, r_end + 1):
                    for c_iter in range(c_start, c_end + 1):
                        current_value += self._eval_cell(r_iter, c_iter, visiting_cells)
            else:
                terms = formula.split('+')
                for term in terms:
                    if term.isdigit() or (term.startswith('-') and term[1:].isdigit()):
                        current_value += int(term)
                    else:
                        ref_r, ref_c = self._parse_cell_ref(term)
                        current_value += self._eval_cell(ref_r, ref_c, visiting_cells)
        else:
            current_value = int(expr)

        self.values[r_idx][c_idx] = current_value
        visiting_cells.remove((r_idx, c_idx))

        return current_value