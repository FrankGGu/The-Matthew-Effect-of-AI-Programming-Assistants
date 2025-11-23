class Solution:
    def minDeletionSize(self, strs: list[str]) -> int:
        num_rows = len(strs)
        num_cols = len(strs[0])

        # sorted_pairs[i] is True if strs[i] and strs[i+1] are already in
        # non-decreasing lexicographical order considering only the columns kept so far.
        # Initially, no columns have been processed, so no pair is definitively sorted.
        sorted_pairs = [False] * (num_rows - 1)

        deleted_count = 0

        # Iterate through each column
        for j in range(num_cols):
            # Flag to determine if the current column 'j' must be deleted
            must_delete_current_col = False

            # Check all adjacent pairs of strings
            for i in range(num_rows - 1):
                # If this pair is already sorted by previous columns, we don't need
                # to check it for this column, as its order is already established.
                if sorted_pairs[i]:
                    continue

                # If strs[i][j] > strs[i+1][j], this column violates the lexicographical order
                # for this pair. We must delete this column.
                if strs[i][j] > strs[i+1][j]:
                    must_delete_current_col = True
                    deleted_count += 1
                    # No need to check other pairs for this column, it's already marked for deletion.
                    break 

            # If the current column was marked for deletion, move to the next column.
            if must_delete_current_col:
                continue

            # If the current column was not deleted, it means it maintains or establishes order.
            # Update sorted_pairs for pairs that are now sorted by this column.
            for i in range(num_rows - 1):
                # If this pair is not yet sorted and this column makes it strictly sorted
                # (i.e., strs[i] comes before strs[i+1]), then mark it as sorted.
                if not sorted_pairs[i] and strs[i][j] < strs[i+1][j]:
                    sorted_pairs[i] = True

            # Optimization: If all adjacent pairs are sorted, no further columns can cause a violation
            # that would require deletion. Any remaining columns can be kept without increasing
            # the deletion count. So, we can stop early.
            if all(sorted_pairs):
                break

        return deleted_count