class FenwickTree:
    def __init__(self, max_val_inclusive):
        # max_val_inclusive is the maximum possible 0-based index this Fenwick Tree will handle.
        # The internal tree array will be 1-indexed and needs size max_val_inclusive + 1.
        self.tree = [0] * (max_val_inclusive + 2) # +1 for 1-indexing, +1 for max_val_inclusive itself
        self.max_idx_internal = max_val_inclusive + 1 # Maximum 1-based index in the tree

    def update(self, index, delta):
        # index is 0-based. Convert to 1-based for internal tree operations.
        index_1based = index + 1
        while index_1based <= self.max_idx_internal:
            self.tree[index_1based] += delta
            index_1based += index_1based & (-index_1based)

    def query(self, index):
        # index is 0-based. Returns the sum of values from 0 up to `index` (inclusive).
        # Convert to 1-based for internal tree operations.
        index_1based = index + 1
        s = 0
        while index_1based > 0:
            s += self.tree[index_1based]
            index_1based -= index_1based & (-index_1based)
        return s

class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        n = len(s)

        # The balance (count of ones - count of zeros) can range from -n to n.
        # We need to map these balance values to non-negative indices for the Fenwick tree.
        # An offset of `n` ensures values from -n to n map to 0 to 2*n.
        # So, the Fenwick tree will operate on indices from 0 to 2*n.
        offset = n
        ft_max_val_inclusive = 2 * n
        ft = FenwickTree(ft_max_val_inclusive)

        total_count = 0
        current_balance = 0 # Represents the balance (ones - zeros) of the prefix s[0...j]

        # Initialize Fenwick tree: The prefix before s[0] (empty prefix) has a balance of 0.
        # We need to account for this initial balance of 0.
        # Store its frequency at index `0 + offset`.
        ft.update(0 + offset, 1)

        for char in s:
            if char == '1':
                current_balance += 1
            else: # char == '0'
                current_balance -= 1

            # For the current prefix ending at `j`, we have `current_balance`.
            # We are looking for previous prefixes `s[0...i-1]` (where `i <= j`)
            # with balance `prev_balance` such that `current_balance - prev_balance > 0`.
            # This means `prev_balance < current_balance`.
            # In the Fenwick tree, `prev_balance` values are stored at `prev_balance + offset`.
            # We need to query the sum of frequencies for all `prev_balance + offset`
            # that are less than `current_balance + offset`.
            # This corresponds to querying up to index `(current_balance + offset) - 1`.
            total_count += ft.query(current_balance + offset - 1)

            # Add the frequency of the current prefix's balance to the Fenwick tree.
            ft.update(current_balance + offset, 1)

        return total_count