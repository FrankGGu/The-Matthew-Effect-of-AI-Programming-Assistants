class Solution:
    def minSwaps(self, grid: List[List[int]]) -> int:
        n = len(grid)
        row_counts = [0] * n

        for i in range(n):
            count = 0
            for j in range(n - 1, -1, -1):
                if grid[i][j] == 1:
                    break
                count += 1
            row_counts[i] = count

        res = 0
        for i in range(n):
            target = i
            found = False
            for j in range(i, n):
                if row_counts[j] >= target:
                    found = True
                    break
            if not found:
                return -1
            res += j - i
            for k in range(j, i, -1):
                row_counts[k] = row_counts[k - 1]
        return res