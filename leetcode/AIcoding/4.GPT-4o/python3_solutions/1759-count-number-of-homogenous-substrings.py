class Solution:
    def countHomogenous(self, s: str) -> int:
        count = total = 0
        mod = 10**9 + 7

        for i in range(len(s)):
            if i > 0 and s[i] == s[i - 1]:
                count += 1
            else:
                count = 1
            total = (total + count) % mod

        return total