class Solution:
    def maxProduct(self, s: str) -> int:
        n = len(s)
        ans = 0
        for i in range(1, n):
            num1 = s[:i]
            num2 = s[i:]
            if len(num1) > 0 and len(num2) > 0:
                ans = max(ans, self.string_to_int(num1) * self.string_to_int(num2))
        return ans

    def string_to_int(self, s: str) -> int:
        res = 0
        for c in s:
            res = res * 10 + int(c)
        return res