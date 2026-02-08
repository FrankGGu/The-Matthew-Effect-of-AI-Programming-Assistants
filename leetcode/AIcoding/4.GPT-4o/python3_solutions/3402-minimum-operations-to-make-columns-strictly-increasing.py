class Solution:
    def minOperations(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        flat = sorted(num for row in grid for num in row)

        def is_valid(mid):
            total = 0
            for i in range(m):
                for j in range(n):
                    total += max(0, mid - flat[i * n + j])
            return total

        lo, hi = 0, flat[-1] + 1
        while lo < hi:
            mid = (lo + hi) // 2
            if is_valid(mid) <= mid:
                hi = mid
            else:
                lo = mid + 1

        return lo