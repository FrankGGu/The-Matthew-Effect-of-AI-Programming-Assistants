import collections

class Solution:
    def minimumOperationsToMakeKPeriodic(self, word: str, k: int) -> int:
        n = len(word)
        num_blocks = n // k

        total_operations = 0

        for j in range(k):
            char_counts = collections.Counter()

            for i in range(num_blocks):
                char = word[i * k + j]
                char_counts[char] += 1

            max_freq_char = 0
            if char_counts:
                max_freq_char = max(char_counts.values())

            total_operations += (num_blocks - max_freq_char)

        return total_operations