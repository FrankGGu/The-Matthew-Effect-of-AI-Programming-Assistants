class Solution:
    def countSubmatrices(self, grid: List[List[int]]) -> int:
        from collections import defaultdict

        n = len(grid)
        m = len(grid[0])
        res = 0

        for i in range(n):
            freq = [0] * m
            for j in range(i, n):
                for k in range(m):
                    if grid[j][k] == 'X':
                        freq[k] += 1
                    else:
                        freq[k] -= 1
                count = defaultdict(int)
                count[0] = 1
                curr = 0
                for val in freq:
                    curr += val
                    res += count[curr]
                    count[curr] += 1
        return res