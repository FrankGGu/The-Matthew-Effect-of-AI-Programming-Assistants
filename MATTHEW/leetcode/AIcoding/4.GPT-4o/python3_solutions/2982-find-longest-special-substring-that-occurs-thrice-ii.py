class Solution:
    def longestSpecialSubstring(self, s: str) -> str:
        n = len(s)
        longest = ""

        for i in range(n):
            for j in range(i + 1, n + 1):
                substring = s[i:j]
                if s.count(substring) == 3 and len(substring) > len(longest):
                    longest = substring

        return longest