class Solution:
    def smallestSubstring(self, s: str) -> int:
        counts = {}
        for char in s:
            counts[char] = counts.get(char, 0) + 1

        if len(counts) <= 1:
            return -1

        min_len = float('inf')
        for char in counts:
            first = s.find(char)
            last = s.rfind(char)
            min_len = min(min_len, last - first + 1)

        return min_len