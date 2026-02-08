class Solution:
    def minimumDeletions(self, s: str) -> int:
        n = len(s)

        # b_count: Tracks the number of 'b's encountered so far in the prefix.
        #          These 'b's would need to be deleted if the prefix is to be all 'a's.
        # a_count_right: Tracks the number of 'a's remaining in the suffix of the string.
        #                These 'a's would need to be deleted if the suffix is to be all 'b's.

        # Initialize a_count_right with the total number of 'a's in the string.
        # This represents the initial state where the entire string is considered the "suffix"
        # (i.e., the split point is before the first character, making the prefix empty).
        a_count_right = s.count('a')

        # Initialize b_count to 0, as the prefix is initially empty.
        b_count = 0

        # Initialize min_deletions.
        # The initial value corresponds to the case where the entire string should be 'b's.
        # In this scenario, all 'a's in the string must be deleted.
        min_deletions = a_count_right 

        # Iterate through the string, effectively considering each character's position
        # as a potential split point between the 'a's part and the 'b's part.
        for char in s:
            if char == 'a':
                # If the current character is 'a', it means this 'a' is no longer in the
                # "right suffix" (it's now part of the "left prefix").
                # So, we decrement a_count_right.
                a_count_right -= 1
            else: # char == 'b'
                # If the current character is 'b', it means this 'b' is now part of the
                # "left prefix". It contributes to the count of 'b's that would need
                # to be deleted if the prefix is to be all 'a's.
                # So, we increment b_count.
                b_count += 1

            # At each step, we calculate the total deletions required for the current split point.
            # The split point is considered to be *after* the current character `char`.
            #   - `b_count` represents the 'b's in the prefix `s[0...current_index]`.
            #     These 'b's must be deleted.
            #   - `a_count_right` represents the 'a's in the suffix `s[current_index+1...n-1]`.
            #     These 'a's must be deleted.
            # We update min_deletions if the current configuration yields fewer deletions.
            min_deletions = min(min_deletions, b_count + a_count_right)

        return min_deletions