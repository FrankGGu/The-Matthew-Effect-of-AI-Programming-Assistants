class Solution:
    def longestSubstring(self, s: str, k: int) -> int:
        if len(s) == 0 or k > len(s):
            return 0

        char_count = Counter(s)

        for char in char_count:
            if char_count[char] < k:
                return max(self.longestSubstring(substring, k) for substring in s.split(char))

        return len(s)