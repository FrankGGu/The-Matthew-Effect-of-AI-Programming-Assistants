class Solution:
    def smallestSubstring(self, s: str) -> str:
        n = len(s)
        if n == 0:
            return ""

        min_len = float('inf')
        min_substring = ""

        last_index = {}

        for i in range(n):
            if s[i] in last_index:
                start = last_index[s[i]]
                length = i - start + 1
                if length < min_len:
                    min_len = length
                    min_substring = s[start:i + 1]
            last_index[s[i]] = i

        return min_substring