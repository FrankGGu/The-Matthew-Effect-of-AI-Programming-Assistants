class Solution:
    def smallestSubstringWithIdenticalCharacters(self, s: str) -> int:
        n = len(s)
        min_len = float('inf')

        for i in range(n):
            for j in range(i + 1, n):
                if s[i] == s[j]:
                    min_len = min(min_len, j - i + 1)

        if min_len == float('inf'):
            return -1
        else:
            return int(min_len)