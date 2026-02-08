import collections

class Solution:
    def minimumDeletions(self, s: str, k: int) -> int:
        counts = collections.Counter(s)

        freqs = list(counts.values())

        # The optimal target frequency 'x' must be at least k.
        # We want to minimize deletions. For each character with original frequency 'f':
        # If f < x, we must delete all 'f' occurrences.
        # If f >= x, we delete 'f - x' occurrences to make its frequency exactly 'x'.
        # The optimal 'x' will be either 'k' or one of the existing frequencies 'f' that is >= k.

        # Collect all unique frequencies and k as potential target values for x.
        candidate_x_values = sorted(list(set(freqs + [k])))

        min_total_deletions = float('inf')

        for x in candidate_x_values:
            # The target frequency 'x' must be at least k.
            if x < k:
                continue

            current_deletions = 0
            for f in freqs:
                if f < x:
                    # If original frequency is less than target x, delete all occurrences.
                    current_deletions += f
                else:
                    # If original frequency is greater than or equal to target x,
                    # delete f - x occurrences to reduce its frequency to x.
                    current_deletions += (f - x)

            min_total_deletions = min(min_total_deletions, current_deletions)

        return min_total_deletions