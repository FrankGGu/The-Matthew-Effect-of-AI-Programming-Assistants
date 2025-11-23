class Solution:
    def prisonAfterNDays(self, cells: List[int], N: int) -> List[int]:
        seen = {}
        while N > 0:
            if tuple(cells) in seen:
                N %= seen[tuple(cells)] - N
            else:
                seen[tuple(cells)] = N
            if N == 0:
                break
            next_day = [0] * 8
            for i in range(1, 7):
                if cells[i-1] == cells[i+1]:
                    next_day[i] = 1
            cells = next_day
            N -= 1
        return cells