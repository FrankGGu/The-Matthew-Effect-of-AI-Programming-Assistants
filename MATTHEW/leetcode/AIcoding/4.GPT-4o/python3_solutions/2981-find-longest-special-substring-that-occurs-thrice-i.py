class Solution:
    def findLongestSpecialSubstring(self, s: str) -> str:
        n = len(s)
        longest = ""

        for length in range(1, n // 3 + 1):
            for i in range(n - length + 1):
                substring = s[i:i + length]
                if s.count(substring) == 3:
                    if len(substring) > len(longest):
                        longest = substring
        return longest