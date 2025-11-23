class Solution:
    def maxSubstring(self, s: str) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for c in s:
            count[c] += 1

        res = 0
        left = 0
        for right in range(len(s)):
            if count[s[right]] == 1:
                res = max(res, right - left + 1)
            else:
                while count[s[right]] > 1:
                    count[s[left]] -= 1
                    left += 1
        return res