class Solution:
    def minArrayEnd(self, n: int, x: int) -> int:
        current_val = x

        # We need to find the (n-1)-th element after x,
        # which means we need to perform the generation step n-1 times.
        # If n=1, a[0]=x, so the loop for generating subsequent elements runs 0 times.
        # current_val remains x, which is the correct a[n-1].
        for _ in range(n - 1):
            # Find the smallest bit position 'pos' where 'current_val' has a 0-bit.
            # This is equivalent to finding the position of the least significant 0-bit.
            pos = 0
            while (current_val >> pos) & 1:
                pos += 1

            # The next element in the array, a[i], will be current_val | (1 << pos).
            # This is the smallest integer k such that:
            # 1. k > current_val (because it has an additional bit set at 'pos' where current_val had 0)
            # 2. (current_val AND k) == current_val (because k is a supermask of current_val)
            # 3. k is not present in the set of previously generated elements.
            #    This is guaranteed because k is strictly greater than current_val,
            #    and current_val is the largest element generated so far.
            current_val = current_val | (1 << pos)

        return current_val