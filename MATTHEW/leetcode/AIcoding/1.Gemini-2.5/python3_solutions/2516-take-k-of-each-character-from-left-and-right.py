from collections import defaultdict

class Solution:
    def takeCharacters(self, s: str, k: int) -> int:
        n = len(s)

        # If k is 0, no characters need to be present in the remaining substring.
        # The longest possible remaining substring is the entire string, so 0 characters removed.
        if k == 0:
            return 0

        # The problem asks for the minimum characters to remove from ends
        # such that the *remaining* substring has at least k of each character 'a', 'b', 'c'.
        # This is equivalent to finding the *longest* contiguous substring that satisfies this condition.
        # Let 'max_len_substring' be the length of this longest substring.
        # The answer will be n - max_len_substring.

        current_counts = defaultdict(int)
        left = 0
        max_len_substring = 0

        for right in range(n):
            current_counts[s[right]] += 1

            # The while loop shrinks the window from the left (advances 'left' pointer)
            # if the current window [left, right] becomes "invalid".
            # A window is "invalid" if it does NOT satisfy the condition of having at least k of each character.
            # So, we shrink if NOT (counts['a'] >= k AND counts['b'] >= k AND counts['c'] >= k).
            while not (current_counts['a'] >= k and current_counts['b'] >= k and current_counts['c'] >= k):
                # If the left pointer has advanced past the right pointer, it means
                # even a single-character window (or empty window) cannot satisfy the condition.
                # This should not happen if a solution is guaranteed to exist, as per problem statement.
                # However, to be safe, we break to prevent infinite loops or errors if k is too large.
                if left > right:
                    break 

                current_counts[s[left]] -= 1
                left += 1

            # After the while loop, if the window [left, right] is valid (or left > right),
            # we update max_len_substring.
            # If left > right, it means no valid window ending at 'right' was found.
            # In a valid state, the current window [left, right] satisfies the condition,
            # and we try to maximize its length.
            if current_counts['a'] >= k and current_counts['b'] >= k and current_counts['c'] >= k:
                max_len_substring = max(max_len_substring, right - left + 1)

        # If no valid substring was found (e.g., if k is too large for the entire string,
        # though problem guarantees a solution exists), max_len_substring remains 0.
        # In that case, n - 0 = n characters would need to be removed.
        # Since a solution is guaranteed, max_len_substring will be at least 1.
        return n - max_len_substring