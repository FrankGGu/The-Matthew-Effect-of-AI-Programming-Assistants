from collections import defaultdict

class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if not s or not t or len(s) < len(t):
            return ""

        t_count = defaultdict(int)
        for char in t:
            t_count[char] += 1

        required = len(t_count)
        formed = 0
        window_count = defaultdict(int)
        left = 0
        min_len = float('inf')
        result = ""

        for right in range(len(s)):
            char = s[right]
            window_count[char] += 1

            if char in t_count and window_count[char] == t_count[char]:
                formed += 1

            while left <= right and formed == required:
                current_len = right - left + 1
                if current_len < min_len:
                    min_len = current_len
                    result = s[left:right+1]

                left_char = s[left]
                window_count[left_char] -= 1
                if left_char in t_count and window_count[left_char] < t_count[left_char]:
                    formed -= 1
                left += 1

        return result