class Solution:
    def missingRolls(self, rolls: List[int], mean: int, n: int) -> List[int]:
        m = len(rolls)
        total = mean * (m + n)
        sum_m = sum(rolls)
        sum_n = total - sum_m
        if sum_n < n or sum_n > 6 * n:
            return []
        res = []
        for i in range(n):
            val = sum_n // (n - i)
            res.append(val)
            sum_n -= val
        return res