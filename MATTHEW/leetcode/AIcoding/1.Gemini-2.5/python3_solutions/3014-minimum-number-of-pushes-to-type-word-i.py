import collections

class Solution:
    def minimumPushes(self, word: str) -> int:
        freq_map = collections.Counter(word)
        sorted_freqs = sorted(freq_map.values(), reverse=True)

        total_pushes = 0
        push_multiplier = 1
        chars_assigned_to_current_level = 0

        for freq in sorted_freqs:
            total_pushes += freq * push_multiplier
            chars_assigned_to_current_level += 1

            if chars_assigned_to_current_level == 8:
                push_multiplier += 1
                chars_assigned_to_current_level = 0

        return total_pushes