class Solution:
    def numWays(self, n: int, k: int) -> int:
        if n == 0:
            return 0
        if n == 1:
            return k
        same, diff = k, k * (k - 1)
        for i in range(2, n):
            new_diff = (same + diff) * (k - 1)
            same, diff = diff, new_diff
        return same + diff