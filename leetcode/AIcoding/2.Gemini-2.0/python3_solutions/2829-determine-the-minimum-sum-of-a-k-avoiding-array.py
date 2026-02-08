class Solution:
    def minimumSum(self, n: int, k: int) -> int:
        s = set()
        res = 0
        i = 1
        count = 0
        while count < n:
            if k - i not in s:
                s.add(i)
                res += i
                count += 1
            i += 1
        return res