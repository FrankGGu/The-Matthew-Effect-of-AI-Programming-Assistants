import collections

class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        counts = collections.defaultdict(int)
        left = 0
        max_freq = 0
        max_length = 0

        for right in range(len(s)):
            counts[s[right]] += 1
            max_freq = max(max_freq, counts[s[right]])

            # If the number of characters to change (current_window_length - max_freq)
            # is greater than k, we need to shrink the window from the left.
            # (right - left + 1) is the current window length.
            if (right - left + 1) - max_freq > k:
                counts[s[left]] -= 1
                left += 1

            # The current window (right - left + 1) is always a valid candidate
            # for the longest repeating character substring.
            # If the window was valid, its length is considered.
            # If it became invalid and was shrunk, the new (smaller) valid length is considered.
            max_length = max(max_length, right - left + 1)

        return max_length