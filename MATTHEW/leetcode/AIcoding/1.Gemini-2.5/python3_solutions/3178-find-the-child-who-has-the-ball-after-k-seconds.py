class Solution:
    def findTheChild(self, n: int, k: int) -> int:
        if n == 1:
            return 0

        cycle_length = 2 * (n - 1)

        effective_k = k % cycle_length

        if effective_k < n:
            return effective_k
        else:
            # The ball has reached n-1 and is now moving backward.
            # It took n-1 passes to reach child n-1.
            # The remaining passes are effective_k - (n-1).
            # The child will be (n-1) - (effective_k - (n-1)).
            return (n - 1) - (effective_k - (n - 1))