class Solution:
    def minSwaps(self, grid: list[list[int]]) -> int:
        n = len(grid)

        trailing_zeros_counts = []
        for r in range(n):
            count = 0
            for c in range(n - 1, -1, -1):
                if grid[r][c] == 0:
                    count += 1
                else:
                    break
            trailing_zeros_counts.append(count)

        swaps = 0

        for i in range(n):
            required_zeros = n - 1 - i

            found_idx = -1
            for j in range(i, n):
                if trailing_zeros_counts[j] >= required_zeros:
                    found_idx = j
                    break

            if found_idx == -1:
                return -1

            if found_idx != i:
                swaps += (found_idx - i)

                val_to_move = trailing_zeros_counts.pop(found_idx)
                trailing_zeros_counts.insert(i, val_to_move)

        return swaps