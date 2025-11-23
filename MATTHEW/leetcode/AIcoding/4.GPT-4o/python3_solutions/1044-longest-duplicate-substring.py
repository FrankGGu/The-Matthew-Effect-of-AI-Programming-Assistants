class Solution:
    def longestDupSubstring(self, s: str) -> str:
        def search(length):
            seen = set()
            h = 0
            base = 256
            mod = 2**63 - 1

            for i in range(length):
                h = (h * base + ord(s[i])) % mod

            seen.add(h)
            for start in range(1, len(s) - length + 1):
                h = (h * base - ord(s[start - 1]) * (base ** length) + ord(s[start + length - 1])) % mod
                if h in seen:
                    return start
                seen.add(h)
            return -1

        left, right = 1, len(s)
        start = 0

        while left < right:
            mid = (left + right) // 2
            if search(mid) != -1:
                start = search(mid)
                left = mid + 1
            else:
                right = mid

        return s[start:start + left - 1]