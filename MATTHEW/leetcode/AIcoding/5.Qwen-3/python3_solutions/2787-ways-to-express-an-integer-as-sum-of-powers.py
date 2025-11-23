class Solution:
    def powSum(self, n: int) -> int:
        def dfs(target, start):
            if target == 0:
                return 1
            if target < 0:
                return 0
            count = 0
            for i in range(start, int(target ** 0.5) + 1):
                count += dfs(target - i * i, i + 1)
            return count
        return dfs(n, 1)