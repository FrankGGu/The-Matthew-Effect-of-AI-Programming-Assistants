import math

class Solution:
    def smallestGoodBase(self, n: str) -> str:
        N = int(n)

        # m is the highest power of k, such that N = k^m + k^(m-1) + ... + k + 1.
        # This implies m+1 is the number of '1's in the base k representation.
        # The maximum possible value for m occurs when k is smallest, i.e., k=2.
        # In this case, N = 2^(m+1) - 1.
        # So, m+1 is approximately log2(N).
        # For N = 10^18, log2(10^18) is approximately 59.79.
        # Thus, m+1 can be at most 59, meaning m can be at most 58.
        # We iterate m from its maximum possible value down to 1.
        # If a base k is found for a larger m, it will generally be smaller than a base found for a smaller m.
        # Therefore, the first k we find (when iterating m downwards) will be the smallest good base.

        # The loop for m starts from int(math.log(N, 2)).
        # For N=3, int(log2(3)) is 1. So m starts at 1.
        # For N=7, int(log2(7)) is 2. So m starts at 2.
        # This range for m is appropriate.
        for m in range(int(math.log(N, 2)), 0, -1):
            # Binary search for k.
            # k must be at least 2.
            # We know N = k^m + k^(m-1) + ... + 1.
            # This implies k^m < N, so k < N^(1/m).
            # A safe upper bound for k is int(N**(1.0/m)) + 1.
            # For m=1, this becomes int(N) + 1 = N+1.
            # For m=58 (max m for N=10^18), N^(1/58) is approx 2.07, so high becomes 2+1=3.
            low, high = 2, int(N**(1.0/m)) + 1

            while low <= high:
                mid_k = (low + high) // 2

                # Calculate sum = 1 + mid_k + mid_k^2 + ... + mid_k^m
                current_sum = 0
                power_k = 1
                overflow = False
                for _ in range(m + 1):
                    current_sum += power_k
                    # Check for potential overflow before multiplying power_k by mid_k.
                    # If power_k * mid_k would exceed N, then the total current_sum will definitely exceed N.
                    # This short-circuits the sum calculation, preventing unnecessary large number arithmetic
                    # and ensuring current_sum doesn't grow excessively beyond N.
                    if _ < m: # Only multiply if not the last term
                        if mid_k > N // power_k: # Equivalent to power_k * mid_k > N
                            overflow = True
                            break
                        power_k *= mid_k

                if overflow:
                    # mid_k is too large, the sum would exceed N.
                    high = mid_k - 1
                elif current_sum == N:
                    # Found a good base k. Since we iterate m downwards, this is the smallest k.
                    return str(mid_k)
                elif current_sum < N:
                    # mid_k is too small, need a larger k.
                    low = mid_k + 1
                else: # current_sum > N
                    # mid_k is too large, need a smaller k.
                    high = mid_k - 1

        # This part of the code should theoretically not be reached for N >= 3.
        # For m=1, N = k+1, which means k = N-1. This is always a valid base.
        # The binary search for m=1 will always find k=N-1.
        # Thus, a solution will always be returned within the loop.
        return str(N - 1)