class Solution:
    def longestSubstring(self, s: str, k: int) -> int:
        if not s:
            return 0

        counts = {}
        for char in s:
            counts[char] = counts.get(char, 0) + 1

        split_char = None
        for char, count in counts.items():
            if count < k:
                split_char = char
                break

        if split_char is None:
            return len(s)

        max_len = 0
        for sub in s.split(split_char):
            max_len = max(max_len, self.longestSubstring(sub, k))

        return max_len