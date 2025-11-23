class Solution:
    def brokenCalc(self, target: int, k: int) -> int:
        res = 0
        while target > k:
            if target % 2 == 1:
                target += 1
                res += 1
            target //= 2
            res += 1
        return res + (k - target)