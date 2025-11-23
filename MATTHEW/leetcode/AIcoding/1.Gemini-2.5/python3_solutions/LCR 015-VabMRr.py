from collections import Counter

class Solution:
    def findAnagrams(self, s: str, p: str) -> list[int]:
        len_s, len_p = len(s), len(p)
        if len_s < len_p:
            return []

        p_count = Counter(p)
        window_count = Counter(s[:len_p])

        result = []
        if p_count == window_count:
            result.append(0)

        for i in range(len_p, len_s):
            window_count[s[i - len_p]] -= 1
            if window_count[s[i - len_p]] == 0:
                del window_count[s[i - len_p]]

            window_count[s[i]] += 1

            if p_count == window_count:
                result.append(i - len_p + 1)

        return result