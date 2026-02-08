class Solution:
    def countCells(self, n: int, m: int, k: int) -> int:
        horz = max(0, n - k + 1)
        vert = max(0, m - k + 1)

        overlap_h = max(0, n - 2 * k + 1)
        overlap_v = max(0, m - 2 * k + 1)

        return horz * m + vert * n - horz * vert - overlap_h * overlap_v * k * k