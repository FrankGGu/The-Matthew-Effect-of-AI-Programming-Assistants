class Solution:
    def numEquivDominoSubstrings(self, s: str) -> int:
        from collections import defaultdict

        def count(s):
            count = 0
            for i in range(len(s)):
                for j in range(i + 1, len(s)):
                    if s[i] == s[j]:
                        count += 1
            return count

        result = 0
        for i in range(len(s)):
            for j in range(i + 1, len(s)):
                if s[i] == s[j]:
                    result += count(s[i:j+1])
        return result