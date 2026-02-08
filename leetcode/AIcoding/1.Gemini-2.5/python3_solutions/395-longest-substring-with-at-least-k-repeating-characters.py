from collections import Counter

class Solution:
    def longestSubstring(self, s: str, k: int) -> int:
        n = len(s)
        if n == 0 or n < k:
            return 0

        counts = Counter(s)

        split_char = None
        for char, freq in counts.items():
            if freq < k:
                split_char = char
                break

        if split_char is None:
            return n

        max_len = 0
        current_substring_start = 0
        for i in range(n):
            if s[i] == split_char:
                if i > current_substring_start:
                    max_len = max(max_len, self.longestSubstring(s[current_substring_start:i], k))
                current_substring_start = i + 1

        if current_substring_start < n:
            max_len = max(max_len, self.longestSubstring(s[current_substring_start:], k))

        return max_len