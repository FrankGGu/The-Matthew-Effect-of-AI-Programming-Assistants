import collections

class Solution:
    def largestVariance(self, s: str) -> int:
        max_variance = 0

        # Get unique characters present in the string s
        unique_chars = list(set(s))

        # Iterate through all possible pairs of characters (char_a, char_b)
        # char_a will be the character whose count we want to maximize.
        # char_b will be the character whose count we want to minimize (or maximize its negative count).
        # We need to find max(count(char_a) - count(char_b)) such that count(char_b) >= 1.

        for char_a in unique_chars:
            for char_b in unique_chars:
                if char_a == char_b:
                    continue

                # Apply a Kadane's-like algorithm variant for each pair.
                # v1_sum: Tracks the current variance (count_a - count_b) for a segment,
                #         where count_b can be 0. This is like a standard Kadane's sum.
                # v2_sum: Tracks the current variance (count_a - count_b) for a segment,
                #         where count_b MUST be at least 1.

                v1_sum = 0
                v2_sum = -float('inf') # Initialize with negative infinity to signify no 'char_b' seen yet for this path.

                for char_in_s in s:
                    if char_in_s == char_a:
                        v1_sum += 1
                        v2_sum += 1
                    elif char_in_s == char_b:
                        # When char_b is encountered:
                        # Option 1: Start a new segment for v2_sum using the current v1_sum.
                        #           This means the current char_b is the first 'b' in this new segment.
                        #           So, the value is v1_sum (from previous chars) - 1 (for current char_b).
                        # Option 2: Continue the existing v2_sum segment.
                        #           This means char_b was already seen, and we just decrement by 1.
                        v2_sum = max(v1_sum - 1, v2_sum - 1)

                        # If char_b is encountered, v1_sum can no longer represent a segment
                        # where char_b count is 0. So, we effectively "invalidate" v1_sum
                        # for future updates to v2_sum, unless it's reset to 0.
                        v1_sum = -float('inf') 

                    # Update the overall maximum variance found so far.
                    # Only v2_sum is considered because it guarantees count(char_b) >= 1.
                    max_variance = max(max_variance, v2_sum)

                    # Kadane's reset logic for v1_sum:
                    # If v1_sum becomes negative, it's better to start a new segment from 0.
                    # This means the previous segment was detrimental to maximizing 'a's.
                    v1_sum = max(0, v1_sum)

                    # v2_sum does not get reset to 0 because it *must* contain at least one char_b.
                    # If it goes negative, it just means that segment is bad, but we can't just discard the `b` count.
                    # It will naturally be replaced by a new `v1_sum - 1` if a better segment starts.

        return max_variance