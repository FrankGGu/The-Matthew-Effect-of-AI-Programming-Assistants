class Solution:
    def longestDupSubstring(self, s: str) -> str:
        n = len(s)
        left, right = 1, n
        ans = ""

        while left <= right:
            mid = (left + right) // 2
            dup = self.find_dup(s, mid)
            if dup:
                ans = dup
                left = mid + 1
            else:
                right = mid - 1

        return ans

    def find_dup(self, s: str, length: int) -> str:
        n = len(s)
        if length > n:
            return ""

        a = 26
        mod = 2**32
        h = 0
        for i in range(length):
            h = (h * a + (ord(s[i]) - ord('a'))) % mod

        seen = {h}
        aL = pow(a, length - 1, mod)

        for i in range(1, n - length + 1):
            h = (h - (ord(s[i - 1]) - ord('a')) * aL) % mod
            h = (h * a + (ord(s[i + length - 1]) - ord('a'))) % mod
            h = (h + mod) % mod  # Ensure h is positive

            if h in seen:
                return s[i:i + length]
            seen.add(h)

        return ""