import collections

class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if not t or not s:
            return ""

        dict_t = collections.Counter(t)

        required = len(dict_t)

        l = 0
        r = 0

        formed = 0
        window_counts = collections.defaultdict(int)

        ans = float('inf'), None, None

        while r < len(s):
            char = s[r]
            window_counts[char] += 1

            if char in dict_t and window_counts[char] == dict_t[char]:
                formed += 1

            while formed == required and l <= r:
                if r - l + 1 < ans[0]:
                    ans = (r - l + 1, l, r)

                char_l = s[l]
                window_counts[char_l] -= 1

                if char_l in dict_t and window_counts[char_l] < dict_t[char_l]:
                    formed -= 1

                l += 1

            r += 1

        if ans[0] == float('inf'):
            return ""
        else:
            return s[ans[1] : ans[2] + 1]