class Solution:
    def maximumLengthSubstring(self, s: str) -> int:
        max_len = 0
        left = 0
        counts = {} 

        for right in range(len(s)):
            char_r = s[right]
            counts[char_r] = counts.get(char_r, 0) + 1

            while counts[char_r] > 2:
                char_l = s[left]
                counts[char_l] -= 1
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len