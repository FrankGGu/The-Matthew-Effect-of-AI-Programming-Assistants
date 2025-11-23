import collections

class Solution:
    def countAnagrams(self, s: str, p: str) -> int:
        if len(s) < len(p):
            return 0

        p_freq = collections.Counter(p)
        window_freq = collections.Counter()

        matched_chars = 0 
        required_distinct_chars = len(p_freq)

        ans = 0
        left = 0

        for right in range(len(s)):
            char_r = s[right]

            window_freq[char_r] += 1

            if char_r in p_freq and window_freq[char_r] == p_freq[char_r]:
                matched_chars += 1

            if right - left + 1 == len(p):
                if matched_chars == required_distinct_chars:
                    ans += 1

                char_l = s[left]

                if char_l in p_freq and window_freq[char_l] == p_freq[char_l]:
                    matched_chars -= 1

                window_freq[char_l] -= 1
                left += 1

        return ans