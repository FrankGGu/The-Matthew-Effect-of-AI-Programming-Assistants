import collections

class Solution:
    def rearrangeCharacters(self, s: str, target: str) -> int:
        s_counts = collections.Counter(s)
        target_counts = collections.Counter(target)

        max_copies = float('inf')

        for char, count in target_counts.items():
            if char not in s_counts:
                return 0
            max_copies = min(max_copies, s_counts[char] // count)

        return max_copies