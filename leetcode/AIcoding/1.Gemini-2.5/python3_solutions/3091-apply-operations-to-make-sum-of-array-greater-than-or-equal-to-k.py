import math

class Solution:
    def minOperations(self, k: int) -> int:
        if k == 1:
            return 0

        # Initialize min_ops with the worst-case scenario:
        # either incrementing the initial '1' to 'k' (k-1 operations),
        # or duplicating the initial '1' (k-1 operations to get k ones).
        min_ops = k - 1

        # Iterate through possible values for 'm', where 'm' is the value
        # we increment the initial '1' to, before starting duplications.
        # The optimal 'm' is typically around sqrt(k).
        # We iterate 'm' from 1 up to int(sqrt(k)) + a small margin to cover
        # integer values around sqrt(k).
        for m in range(1, int(math.sqrt(k)) + 2):
            # Operations to get 'm' from '1': m - 1 increments.
            # We now have one element 'm'.
            # We need to reach a sum of at least 'k'.
            # Number of 'm's required: ceil(k / m).
            # In integer arithmetic, ceil(a / b) can be calculated as (a + b - 1) // b.
            num_m_needed = (k + m - 1) // m

            # Since we already have one 'm', we need num_m_needed - 1 additional 'm's.
            # Each additional 'm' requires one duplication operation.
            duplication_ops = num_m_needed - 1

            # Total operations for this choice of 'm':
            current_ops = (m - 1) + duplication_ops

            min_ops = min(min_ops, current_ops)

        return min_ops