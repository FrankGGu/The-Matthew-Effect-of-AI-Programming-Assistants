import collections

class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if not t:
            return ""

        target_counts = collections.Counter(t)
        window_counts = collections.Counter()

        required_chars = len(target_counts)
        matched_unique_chars = 0

        min_len = float('inf')
        min_start = 0

        left = 0
        for right in range(len(s)):
            char_r = s[right]
            window_counts[char_r] += 1

            if char_r in target_counts and window_counts[char_r] == target_counts[char_r]:
                matched_unique_chars += 1

            while matched_unique_chars == required_chars:
                current_window_len = right - left + 1
                if current_window_len < min_len:
                    min_len = current_window_len
                    min_start = left

                char_l = s[left]
                if char_l in target_counts and window_counts[char_l] == target_counts[char_l]:
                    matched_unique_chars -= 1

                window_counts[char_l] -= 1
                left += 1

        if min_len == float('inf'):
            return ""
        else:
            return s[min_start : min_start + min_len]