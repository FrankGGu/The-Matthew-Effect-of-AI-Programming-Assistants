import collections

class Solution:
    def maxEqualRowsAfterFlips(self, mat: list[list[int]]) -> int:
        counts = collections.Counter()
        for row in mat:
            # Create a canonical representation for each row.
            # If the row starts with 1, flip all its bits to make it start with 0.
            # This groups rows that are identical or complements of each other.
            if row[0] == 1:
                # Flip all bits in the row
                flipped_row = tuple(1 - x for x in row)
                counts[flipped_row] += 1
            else:
                # Row already starts with 0, use it as is
                counts[tuple(row)] += 1

        if not counts:
            return 0

        return max(counts.values())