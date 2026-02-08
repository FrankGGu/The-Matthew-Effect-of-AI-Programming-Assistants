import collections
import math

class Solution:
    def countKSubsequencesWithMaxBeauty(self, s: str, k: int) -> int:
        freq = collections.Counter(s)

        if len(freq) < k:
            return 0

        freq_values = list(freq.values())
        freq_values.sort(reverse=True)

        # The k-th largest frequency (0-indexed) determines the threshold.
        # All characters with frequency strictly greater than this must be chosen.
        # Characters with frequency exactly equal to this might be chosen.
        threshold_freq = freq_values[k - 1]

        num_chars_above_threshold = 0
        num_chars_at_threshold = 0
        for f_val in freq.values():
            if f_val > threshold_freq:
                num_chars_above_threshold += 1
            elif f_val == threshold_freq:
                num_chars_at_threshold += 1

        # We must select all characters with frequency > threshold_freq.
        # These are `num_chars_above_threshold` characters.
        # We need to select `k - num_chars_above_threshold` more characters.
        # These additional characters must come from those with frequency == threshold_freq
        # to achieve the maximum beauty.

        needed_from_threshold = k - num_chars_above_threshold

        # The number of ways to choose the remaining characters is
        # C(num_chars_at_threshold, needed_from_threshold).
        return math.comb(num_chars_at_threshold, needed_from_threshold)