class Solution:
    def minimumTime(self, s: str, k: int) -> int:
        n = len(s)
        ans = 0
        i = 0
        while i < n:
            if s[i] == '1':
                ans += 1
                i += k
            else:
                i += 1
        return ans