class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        n = len(s)

        # ones_in_prefix: count of '1's in the prefix s[0...i]
        # zeros_in_suffix: count of '0's in the suffix s[i+1...n-1]

        # Initialize ones_in_prefix to 0.
        ones_in_prefix = 0

        # Initialize zeros_in_suffix to the total count of '0's in the string.
        # This represents the cost if the entire string becomes '1's (split point at index 0).
        zeros_in_suffix = s.count('0')

        # Initialize min_flips with the cost of making the entire string '1's.
        min_flips = zeros_in_suffix

        # Iterate through the string, considering each character s[i] as the potential boundary.
        # The split point is considered to be after s[i].
        # So, s[0...i] should be '0's and s[i+1...n-1] should be '1's.
        for i in range(n):
            if s[i] == '0':
                # If s[i] is '0', it moves from the suffix part to the prefix part.
                # It no longer needs to be flipped if the suffix is all '1's.
                zeros_in_suffix -= 1
            else: # s[i] == '1'
                # If s[i] is '1', it moves from the suffix part to the prefix part.
                # It now needs to be flipped to '0' if the prefix is all '0's.
                ones_in_prefix += 1

            # Calculate the current flips needed for this split point.
            # flips = (count of '1's in s[0...i] to be flipped to '0') + 
            #         (count of '0's in s[i+1...n-1] to be flipped to '1')
            current_flips = ones_in_prefix + zeros_in_suffix

            # Update the minimum flips found so far.
            min_flips = min(min_flips, current_flips)

        # The loop covers all split points from 0 to n-1.
        # The last iteration (i=n-1) effectively considers the split point at index n,
        # where the entire string becomes '0's.
        # In this case, ones_in_prefix will be the total count of '1's, and zeros_in_suffix will be 0.
        # So current_flips = total_ones_count + 0, which is the cost to make the entire string '0's.

        return min_flips