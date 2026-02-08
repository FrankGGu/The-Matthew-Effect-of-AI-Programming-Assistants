from collections import Counter

class Solution:
    def balancedString(self, s: str) -> int:
        n = len(s)
        target = n // 4

        # Calculate total counts of each character in the string
        total_counts = Counter(s)

        # If the string is already balanced, no replacement is needed
        if all(total_counts[char] == target for char in 'QWER'):
            return 0

        # Initialize sliding window variables
        left = 0
        min_len = n  # Initialize with the maximum possible length

        # window_counts will store the frequency of characters within the current window s[left...right]
        window_counts = Counter()

        # Helper function to check if the characters *outside* the current window are "balanced enough".
        # "Balanced enough" means that for each character 'c', its count outside the window
        # does not exceed the target count (n/4).
        def is_balanced_enough():
            for char in 'QWER':
                # The count of 'char' outside the window is total_counts[char] - window_counts[char].
                # If this count is greater than 'target', it means we have too many 'char's
                # outside the current window. We cannot fix this by replacing characters
                # *inside* the window, so this window is not a valid candidate.
                if total_counts[char] - window_counts[char] > target:
                    return False
            return True

        # Iterate with the right pointer to expand the window
        for right in range(n):
            window_counts[s[right]] += 1

            # While the "outside" part (characters not in s[left...right]) is balanced enough,
            # we have found a potential candidate substring s[left...right].
            # We try to shrink the window from the left to find the minimum length.
            while left <= right and is_balanced_enough():
                min_len = min(min_len, right - left + 1)

                # Shrink the window from the left
                window_counts[s[left]] -= 1
                left += 1

        return min_len