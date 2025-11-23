from collections import defaultdict

class Solution:
    def maxFreq(self, s: str, maxLetters: int, minLength: int, maxLength: int) -> int:
        # The key insight is that if a substring S of length L (minLength <= L <= maxLength)
        # satisfies the maxLetters condition and occurs k times, then its prefix S_prefix
        # of length minLength must also satisfy the maxLetters condition (or fewer unique characters)
        # and occurs at least k times.
        # Therefore, to find the maximum frequency, we only need to consider substrings of length minLength.
        # The maxLength constraint becomes irrelevant for finding the maximum frequency.

        n = len(s)
        if n < minLength:
            return 0

        # Dictionary to store counts of valid substrings
        substring_counts = defaultdict(int)

        # Frequency array for characters in the current window (a-z)
        char_freq = [0] * 26
        unique_chars_count = 0

        # Initialize the first window [0, minLength-1]
        for i in range(minLength):
            char_idx = ord(s[i]) - ord('a')
            if char_freq[char_idx] == 0:
                unique_chars_count += 1
            char_freq[char_idx] += 1

        # Check the first window
        if unique_chars_count <= maxLetters:
            substring_counts[s[0:minLength]] += 1

        # Slide the window
        # The window moves from index 1 up to n - minLength
        # The left boundary is 'i', right boundary is 'i + minLength - 1'
        for i in range(1, n - minLength + 1):
            # Remove the character s[i-1] from the left of the window
            char_idx_out = ord(s[i-1]) - ord('a')
            char_freq[char_idx_out] -= 1
            if char_freq[char_idx_out] == 0:
                unique_chars_count -= 1

            # Add the character s[i + minLength - 1] to the right of the window
            char_idx_in = ord(s[i + minLength - 1]) - ord('a')
            if char_freq[char_idx_in] == 0:
                unique_chars_count += 1
            char_freq[char_idx_in] += 1

            # Check the current window
            if unique_chars_count <= maxLetters:
                substring_counts[s[i:i+minLength]] += 1

        # Find the maximum frequency among all valid substrings
        max_freq = 0
        for count in substring_counts.values():
            max_freq = max(max_freq, count)

        return max_freq