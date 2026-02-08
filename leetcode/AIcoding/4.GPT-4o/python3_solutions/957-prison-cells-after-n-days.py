class Solution:
    def prisonAfterNDays(self, cells: List[int], N: int) -> List[int]:
        seen = {}
        while N > 0:
            state = tuple(cells)
            if state in seen:
                N %= seen[state] - N
            seen[state] = N
            if N <= 0:
                break
            N -= 1
            new_cells = [0] * 8
            for i in range(1, 7):
                new_cells[i] = 1 if cells[i - 1] == cells[i + 1] else 0
            cells = new_cells
        return cells