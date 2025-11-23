class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if not s or not t:
            return ""

        from collections import defaultdict

        required = defaultdict(int)
        for char in t:
            required[char] += 1

        required_chars = len(required)
        current_chars = defaultdict(int)
        formed = 0

        left = 0
        right = 0
        min_length = float('inf')
        result = (0, 0)

        while right < len(s):
            char = s[right]
            current_chars[char] += 1

            if current_chars[char] == required[char]:
                formed += 1

            while formed == required_chars and left <= right:
                current_length = right - left + 1
                if current_length < min_length:
                    min_length = current_length
                    result = (left, right)

                left_char = s[left]
                current_chars[left_char] -= 1
                if current_chars[left_char] < required[left_char]:
                    formed -= 1
                left += 1

            right += 1

        return s[result[0]:result[1]+1] if min_length != float('inf') else ""