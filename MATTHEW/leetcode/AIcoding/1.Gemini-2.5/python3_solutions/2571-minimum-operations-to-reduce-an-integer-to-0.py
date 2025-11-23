class Solution:
    def minOperations(self, n: int) -> int:
        # dp[0] represents the minimum operations to reduce the current number (n) to 0,
        # assuming no carry-in from the previous bit.
        # dp[1] represents the minimum operations to reduce the current number (n) to 2^k
        # (where k is the current bit position), assuming no carry-in from the previous bit.
        # This effectively means we have an extra +2^k that needs to be cancelled out later
        # (by a -2^k at the current position, or a -2^(k+1) at the next position, etc.).

        # Initialize dp states for the 0-th bit (before processing any bits)
        # If n is 0, 0 operations.
        dp0 = 0 
        # If n is 1 (i.e., 2^0), we need 1 operation (+2^0).
        # Or, if we want to make 0 into 2^0, it costs 1 operation.
        dp1 = 1 

        # We iterate through the bits of n.
        # The loop should run enough times to cover all bits of n,
        # and potentially one more iteration for any final carry.
        # For n up to 10^9, n.bit_length() is at most 30.
        # So, we need to process up to bit 30. One more iteration for carry means 31 iterations.
        # A safe upper bound for the number of iterations is 32 (for a 32-bit integer).
        for _ in range(32):
            # Get the current least significant bit of n
            bit = n & 1
            # Shift n to the right to process the next bit in the next iteration
            n >>= 1

            # Initialize new dp states for the next bit position
            new_dp0 = float('inf')
            new_dp1 = float('inf')

            # --- Calculate new_dp0 (cost to make current bit 0, no carry out) ---
            # Option 1: Coming from dp0 (no carry-in from previous bit)
            #   If current bit is 0: No operation needed at 2^k. Cost is dp0.
            #   If current bit is 1: Subtract 2^k. Cost is dp0 + 1.
            new_dp0 = min(new_dp0, dp0 + bit)

            # Option 2: Coming from dp1 (carry-in of 1 from previous bit)
            #   Effective current bit is (bit + 1). We want it to be 0.
            #   If effective bit is 1 (i.e., bit was 0): Subtract 2^k. Cost is dp1 + 1.
            #   If effective bit is 2 (i.e., bit was 1): This means 0 at current bit, 
            #     and a carry of 1 to the next bit. This contributes to new_dp1, not new_dp0.
            if bit == 0:
                new_dp0 = min(new_dp0, dp1 + 1)

            # --- Calculate new_dp1 (cost to make current bit 1, with carry out) ---
            # Option 1: Coming from dp0 (no carry-in from previous bit)
            #   Current bit is 'bit'. We want it to effectively be '1' (and carry '1' out).
            #   If current bit is 0: Add 2^k. Cost is dp0 + 1.
            #   If current bit is 1: No operation needed at 2^k. Cost is dp0.
            new_dp1 = min(new_dp1, dp0 + (1 - bit))

            # Option 2: Coming from dp1 (carry-in of 1 from previous bit)
            #   Effective current bit is (bit + 1). We want it to effectively be '1' (and carry '1' out).
            #   If effective bit is 1 (i.e., bit was 0): No operation needed at 2^k. Cost is dp1.
            #   If effective bit is 2 (i.e., bit was 1): This means 0 at current bit, 
            #     and a carry of 1 to the next bit. This is exactly what new_dp1 represents. Cost is dp1.
            new_dp1 = min(new_dp1, dp1 + bit)

            # Update dp states for the next iteration
            dp0 = new_dp0
            dp1 = new_dp1

        # After processing all bits, dp0 holds the minimum operations to reduce n to 0.
        # dp1 holds the minimum operations to reduce n to 2^(L) (where L is the bit length).
        # To reduce 2^L to 0, we need one more operation (-2^L).
        # So, the final answer is the minimum of these two possibilities.
        return min(dp0, dp1 + 1)