import collections

class Solution:
    def longestPalindrome(self, s: str) -> int:
        char_counts = collections.Counter(s)

        length = 0
        has_odd_count = False

        for count in char_counts.values():
            length += (count // 2) * 2
            if count % 2 == 1:
                has_odd_count = True

        if has_odd_count:
            length += 1

        return length