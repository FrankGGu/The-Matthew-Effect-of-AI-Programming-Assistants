class Solution:
    def longestRepeating(self, s: str, k: int) -> int:
        n = len(s)
        max_length = 0
        for i in range(n):
            for j in range(i, n):
                sub = s[i:j+1]
                counts = {}
                for char in sub:
                    counts[char] = counts.get(char, 0) + 1
                max_count = 0
                for char in counts:
                    max_count = max(max_count, counts[char])
                if len(sub) - max_count <= k:
                    max_length = max(max_length, len(sub))
        return max_length