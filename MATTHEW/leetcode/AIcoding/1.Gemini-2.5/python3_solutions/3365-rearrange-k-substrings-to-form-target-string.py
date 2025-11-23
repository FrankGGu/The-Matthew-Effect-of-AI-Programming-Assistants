import collections

class Solution:
    def rearrangeCharacters(self, s: str, target: str) -> int:
        s_counts = collections.Counter(s)
        target_counts = collections.Counter(target)

        max_copies = float('inf')

        for char, count_in_target in target_counts.items():
            if char not in s_counts:
                return 0

            possible_copies_for_char = s_counts[char] // count_in_target
            max_copies = min(max_copies, possible_copies_for_char)

        return max_copies