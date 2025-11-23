import collections

class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if not t:
            return ""

        dict_t = collections.Counter(t)

        window_counts = collections.defaultdict(int)

        formed = 0
        required = len(dict_t)

        l = 0
        min_len = float('inf')
        min_start = 0

        for r in range(len(s)):
            char = s[r]
            window_counts[char] += 1

            if char in dict_t and window_counts[char] == dict_t[char]:
                formed += 1

            while formed == required:
                current_window_len = r - l + 1
                if current_window_len < min_len:
                    min_len = current_window_len
                    min_start = l

                char_l = s[l]
                window_counts[char_l] -= 1

                if char_l in dict_t and window_counts[char_l] < dict_t[char_l]:
                    formed -= 1

                l += 1

        if min_len == float('inf'):
            return ""
        else:
            return s[min_start : min_start + min_len]