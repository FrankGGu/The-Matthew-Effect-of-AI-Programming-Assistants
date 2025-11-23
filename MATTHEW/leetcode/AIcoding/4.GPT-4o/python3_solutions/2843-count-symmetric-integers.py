class Solution:
    def countSymmetricIntegers(self, low: int, high: int) -> int:
        def is_symmetric(n):
            s = str(n)
            mid = len(s) // 2
            return sum(int(s[i]) for i in range(mid)) == sum(int(s[-(i + 1)]) for i in range(mid))

        count = 0
        for i in range(low, high + 1):
            if len(str(i)) % 2 == 0 and is_symmetric(i):
                count += 1
        return count