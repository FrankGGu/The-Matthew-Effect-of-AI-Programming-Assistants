class Solution:
    def longestString(self, x: int, y: int, z: int) -> int:
        # Calculate the maximum number of 'AA' and 'BB' strings that can be arranged
        # in an alternating sequence (e.g., AABBAA or BBAABB).
        # We can use min(x, y) pairs of (AA, BB). This accounts for 2 * min(x, y) strings.
        # If x != y, there's one more string of the majority type that can be added
        # to extend the alternating sequence (e.g., AABBAA if x > y).
        # If x == y, we use 2 * x strings.
        # This can be compactly written as:
        count_aa_bb_alternating = 2 * min(x, y) + (1 if x != y else 0)

        # Now consider the 'AB' strings.
        # An 'AB' string cannot be adjacent to another 'AB' string.
        # The 'count_aa_bb_alternating' strings create 'count_aa_bb_alternating + 1'
        # possible slots where 'AB' strings can be placed (including before the first
        # and after the last 'AA'/'BB' string).
        # Since 'AB' cannot be adjacent to 'AB', each slot can take at most one 'AB' string.
        # So, we can use at most 'count_aa_bb_alternating + 1' 'AB' strings.
        # We have 'z' 'AB' strings available.
        # Thus, the number of 'AB' strings we can use is min(z, count_aa_bb_alternating + 1).
        count_ab_used = min(z, count_aa_bb_alternating + 1)

        # The total number of strings used is the sum of alternating 'AA'/'BB' strings
        # and the 'AB' strings inserted into their slots.
        total_strings_used = count_aa_bb_alternating + count_ab_used

        # Each string ('AA', 'BB', 'AB') has a length of 2.
        # So, the total length of the longest new string is 2 times the total number of strings used.
        return 2 * total_strings_used