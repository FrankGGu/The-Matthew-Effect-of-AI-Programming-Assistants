class Solution:
    def maxTheNumber(self, k: int) -> int:

        def calculate_total_price(x: int) -> int:
            if x == 0:
                return 0

            total_price = 0
            # Iterate up to 60 bits. The maximum possible value for x (around 2 * 10^15)
            # is less than 2^61. So, bit positions p from 0 to 60 are relevant.
            for p in range(61): 
                # Calculate countSetBits(x, p): number of times the p-th bit is set
                # in numbers from 1 to x.
                # The formula counts set bits in numbers from 0 to x.
                # Since 0 has no set bits, this is equivalent to counting from 1 to x.

                # A block of 2^(p+1) numbers (e.g., 0-1, 0-3, 0-7, etc.)
                # contains 2^p numbers where the p-th bit is set.
                block_size = 1 << (p + 1) # 2^(p+1)
                half_block = 1 << p       # 2^p

                # Number of full blocks of size block_size within (x + 1) numbers (0 to x)
                num_blocks = (x + 1) // block_size

                # Remaining numbers after full blocks
                remainder = (x + 1) % block_size

                # Total count of set p-th bits:
                # Contribution from full blocks + contribution from the partial block
                count = num_blocks * half_block + max(0, remainder - half_block)

                # Add contribution to total_price
                # The price for the p-th bit is (p + 1).
                total_price += (p + 1) * count

                # Optimization: If total_price already exceeds k, we can stop early.
                # This is crucial for performance, especially for large x values,
                # and correctly signals that this 'mid' value is too high.
                # We return k + 1 (or any value > k) to indicate it's too expensive.
                if total_price > k:
                    return k + 1 

            return total_price

        low = 0
        # The upper bound for x.
        # If price(i) were always 1, x could be up to k (10^18).
        # However, price(i) grows with i (roughly log(i)), so P(x) grows faster than x.
        # For k = 10^18, x is estimated to be around 1.1 * 10^15.
        # A safe upper bound like 2 * 10^15 covers this.
        high = 2 * 10**15 
        ans = 0 # Stores the maximum x found so far that satisfies the condition

        # Binary search for the maximum x
        while low <= high:
            mid = low + (high - low) // 2

            current_sum = calculate_total_price(mid)

            if current_sum <= k:
                # If the sum of prices up to 'mid' is within budget,
                # 'mid' is a possible answer. Try for a larger 'x'.
                ans = mid
                low = mid + 1 
            else:
                # If the sum of prices up to 'mid' exceeds budget,
                # 'mid' is too large. Try a smaller 'x'.
                high = mid - 1 

        return ans