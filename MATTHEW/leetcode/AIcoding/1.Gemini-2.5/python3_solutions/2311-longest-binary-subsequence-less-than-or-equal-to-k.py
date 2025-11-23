class Solution:
    def longestSubsequence(self, s: str, k: int) -> int:
        current_val = 0
        current_len = 0

        for i in range(len(s) - 1, -1, -1):
            char = s[i]
            if char == '0':
                current_len += 1
            else:  # char == '1'
                # Calculate the place value for this '1' if it were added.
                # It would be at position `current_len` (0-indexed from right)
                # in the subsequence.
                place_value = 1 << current_len

                # Check if adding this '1' (with its place value) would exceed k.
                # If place_value itself is already greater than k - current_val,
                # then current_val + place_value would be greater than k.
                # This also effectively handles cases where place_value becomes
                # very large, preventing unnecessary addition attempts.
                if current_val + place_value <= k:
                    current_val += place_value
                    current_len += 1

        return current_len