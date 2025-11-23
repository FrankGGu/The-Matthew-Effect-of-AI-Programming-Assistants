class Solution:
    def kAvoidingArray(self, n: int, k: int) -> int:
        res = 0
        for i in range(1, n + 1):
            if i % k != 0:
                res += i
        return res