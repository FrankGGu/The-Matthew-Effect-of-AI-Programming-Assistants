class Solution:
    def minSwaps(self, grid: List[List[int]]) -> int:
        n = len(grid)
        zeros = [0] * n

        for i in range(n):
            count = 0
            for j in range(n-1, -1, -1):
                if grid[i][j] == 0:
                    count += 1
                else:
                    break
            zeros[i] = count

        swaps = 0
        for i in range(n):
            required = n - 1 - i
            if zeros[i] < required:
                j = i
                while j < n and zeros[j] < required:
                    j += 1
                if j == n:
                    return -1
                for k in range(j, i, -1):
                    zeros[k], zeros[k-1] = zeros[k-1], zeros[k]
                    swaps += 1

        return swaps