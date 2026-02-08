class Solution:
    def prisonAfterNDays(self, cells: List[int], n: int) -> List[int]:
        seen = {}
        while n > 0:
            pattern = tuple(cells)
            if pattern in seen:
                n %= (seen[pattern] - n)
            else:
                seen[pattern] = n

            if n > 0:
                new_cells = [0] * len(cells)
                for i in range(1, len(cells) - 1):
                    new_cells[i] = 1 - (cells[i-1] ^ cells[i+1])
                cells = new_cells
                n -= 1
        return cells