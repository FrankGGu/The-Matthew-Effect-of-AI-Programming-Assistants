class Solution:
    def maximumLengthSubstring(self, s: str) -> int:
        max_len = 0
        left = 0
        count = {}

        for right in range(len(s)):
            char = s[right]
            count[char] = count.get(char, 0) + 1

            while count[char] > 2:
                left_char = s[left]
                count[left_char] -= 1
                if count[left_char] == 0:
                    del count[left_char]
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len