import collections

class Solution:
    def minDeletions(self, s: str) -> int:
        freq_map = collections.Counter(s)

        operations = 0
        used_frequencies = set()

        for char, freq in freq_map.items():
            current_freq = freq
            while current_freq > 0 and current_freq in used_frequencies:
                current_freq -= 1
                operations += 1

            if current_freq > 0:
                used_frequencies.add(current_freq)

        return operations