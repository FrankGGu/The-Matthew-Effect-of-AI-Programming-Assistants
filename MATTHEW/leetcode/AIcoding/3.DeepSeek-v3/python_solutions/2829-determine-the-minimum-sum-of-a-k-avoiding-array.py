class Solution:
    def minimumSum(self, n: int, k: int) -> int:
        res = 0
        used = set()
        num = 1
        for _ in range(n):
            while num in used or (k - num in used and k - num != num):
                num += 1
            res += num
            used.add(num)
            num += 1
        return res