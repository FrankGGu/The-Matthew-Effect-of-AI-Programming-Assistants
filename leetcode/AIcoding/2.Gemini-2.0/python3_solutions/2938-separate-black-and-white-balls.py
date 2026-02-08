class Solution:
    def minimumSteps(self, s: str) -> int:
        ans = 0
        pos = 0
        for i in range(len(s)):
            if s[i] == '1':
                ans += i - pos
                pos += 1
        return ans