class Solution:
    def sumDistance(self, positions: List[int], power: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(positions)
        for i in range(n):
            positions[i] += power[i]
        positions.sort()
        res = 0
        for i in range(n):
            res = (res + positions[i] * i - positions[i] * (n - 1 - i)) % MOD
        return res