class Solution:
    def palindrome(self, n: int, k: int) -> str:
        if k == 0:
            return "0" if n == 1 else ""
        half = (k + 1) // 2
        first = 10 ** (half - 1)
        last = 10 ** half
        for i in range(first, last):
            s = str(i)
            if k % 2 == 0:
                p = s + s[::-1]
            else:
                p = s + s[-2::-1]
            if len(p) == n:
                return p
        return ""