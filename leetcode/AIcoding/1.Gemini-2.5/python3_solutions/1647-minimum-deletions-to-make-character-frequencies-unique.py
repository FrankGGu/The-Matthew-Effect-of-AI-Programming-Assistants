import collections

class Solution:
    def minDeletions(self, s: str) -> int:
        freq_map = collections.Counter(s)

        deletions = 0
        used_frequencies = set()

        for char_freq in freq_map.values():
            current_freq = char_freq
            while current_freq > 0 and current_freq in used_frequencies:
                current_freq -= 1
                deletions += 1

            if current_freq > 0:
                used_frequencies.add(current_freq)

        return deletions