class Solution:
    def spiralMatrixIII(self, rows: int, cols: int, rStart: int, cStart: int) -> list[list[int]]:
        result = [[rStart, cStart]]
        total_cells = rows * cols
        dr = 0
        dc = 1
        step = 1
        r = rStart
        c = cStart

        while len(result) < total_cells:
            for _ in range(2):
                for _ in range(step):
                    r += dr
                    c += dc
                    if 0 <= r < rows and 0 <= c < cols:
                        result.append([r, c])
                dr, dc = dc, -dr
            step += 1

        return result