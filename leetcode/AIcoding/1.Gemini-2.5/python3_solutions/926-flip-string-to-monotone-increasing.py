class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        n = len(s)

        # ones_to_left_of_split: counts '1's in the prefix that need to be flipped to '0'.
        # zeros_to_right_of_split: counts '0's in the suffix that need to be flipped to '1'.

        # Case 1: The entire string is '1's (split point at index 0).
        # No '0's in the left part, all '0's in the string need to be flipped to '1'.
        ones_to_left_of_split = 0
        zeros_to_right_of_split = s.count('0')

        min_flips = zeros_to_right_of_split

        # Iterate through all possible split points.
        # The loop considers s[i] as the character at the current position.
        # After processing s[i], we calculate flips for the split point just after s[i].
        # This means s[0...i] should be '0's and s[i+1...n-1] should be '1's.
        for i in range(n):
            if s[i] == '0':
                # This '0' was in the 'right' part (s[i...n-1]) and would have been flipped to '1'.
                # Now it moves to the 'left' part (s[0...i]) and is correctly '0', so no flip needed for it.
                zeros_to_right_of_split -= 1
            else: # s[i] == '1'
                # This '1' was in the 'right' part (s[i...n-1]) and was correctly '1'.
                # Now it moves to the 'left' part (s[0...i]) and needs to be flipped to '0'.
                ones_to_left_of_split += 1

            # The current number of flips for the split point after s[i]
            current_flips = ones_to_left_of_split + zeros_to_right_of_split
            min_flips = min(min_flips, current_flips)

        # The loop covers split points from 1 to n.
        # The initial min_flips covers the split point 0 (all '1's).
        # The final min_flips will contain the minimum.
        return min_flips