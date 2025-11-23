class Solution:
    def minWindow(self, s: str, t: str) -> str:
        from collections import defaultdict

        if not s or not t or len(s) < len(t):
            return ""

        char_count = defaultdict(int)
        for char in t:
            char_count[char] += 1

        required = len(char_count)
        formed = 0
        left = 0
        min_length = float('inf')
        result = (0, 0)

        for right in range(len(s)):
            char = s[right]
            if char in char_count:
                char_count[char] -= 1
                if char_count[char] == 0:
                    formed += 1

            while formed == required:
                current_length = right - left + 1
                if current_length < min_length:
                    min_length = current_length
                    result = (left, right)

                left_char = s[left]
                if left_char in char_count:
                    char_count[left_char] += 1
                    if char_count[left_char] > 0:
                        formed -= 1
                left += 1

        return s[result[0]:result[1]+1] if min_length != float('inf') else ""