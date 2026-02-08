import collections

class Solution:
    def canConstruct(self, s: str, k: int) -> bool:
        n = len(s)
        if k > n:
            return False

        char_counts = collections.Counter(s)

        odd_freq_chars = 0
        for count in char_counts.values():
            if count % 2 != 0:
                odd_freq_chars += 1

        return odd_freq_chars <= k