from collections import Counter

class Solution:
    def findAnagrams(self, s: str, p: str) -> list[int]:
        len_s = len(s)
        len_p = len(p)

        if len_s < len_p:
            return []

        p_counts = Counter(p)
        window_counts = Counter()

        result = []
        left = 0

        for right in range(len_s):
            window_counts[s[right]] += 1

            if right - left + 1 == len_p:
                if window_counts == p_counts:
                    result.append(left)

                window_counts[s[left]] -= 1
                left += 1

        return result