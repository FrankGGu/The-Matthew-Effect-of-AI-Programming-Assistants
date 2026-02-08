class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        left = 0
        max_len = 0
        freq = {}
        max_freq = 0

        for right in range(len(s)):
            char = s[right]
            freq[char] = freq.get(char, 0) + 1
            max_freq = max(max_freq, freq[char])

            while (right - left + 1) - max_freq > k:
                freq[s[left]] -= 1
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len