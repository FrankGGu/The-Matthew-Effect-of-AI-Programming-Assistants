class Solution:
    def prisonAfterNDays(self, cells: List[int], N: int) -> List[int]:
        seen = {}
        for i in range(N):
            s = str(cells)
            if s in seen:
                cycle_length = i - seen[s]
                remaining_days = (N - i) % cycle_length
                return self.prisonAfterNDays(cells, remaining_days)
            seen[s] = i
            cells = self.nextDay(cells)
        return cells

    def nextDay(self, cells):
        res = [0] * 8
        for i in range(1, 7):
            res[i] = 1 if cells[i-1] == cells[i+1] else 0
        return res