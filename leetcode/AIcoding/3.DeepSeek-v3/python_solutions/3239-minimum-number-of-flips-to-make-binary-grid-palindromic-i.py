class Solution:
    def minFlips(self, grid: List[List[int]]) -> int:
        n = len(grid)
        res = float('inf')

        for mask in range(0, 1 << n):
            flips = 0
            for i in range(n):
                for j in range(n):
                    if j < n - 1 - j:
                        a = grid[i][j]
                        b = grid[i][n - 1 - j]
                        if (mask >> i) & 1:
                            a ^= 1
                        if (mask >> (n - 1 - i)) & 1:
                            b ^= 1
                        if a != b:
                            flips += 1
                    elif j == n - 1 - j:
                        a = grid[i][j]
                        if (mask >> i) & 1:
                            a ^= 1
                        if (mask >> (n - 1 - i)) & 1:
                            a ^= 1
                        if a != 0:
                            flips += 1
            res = min(res, flips)

        return res if res != float('inf') else -1