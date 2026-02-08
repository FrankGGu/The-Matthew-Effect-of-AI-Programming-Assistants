class Solution:
    def minNonZeroProduct(self, p: int) -> int:
        MOD = 10**9 + 7

        # The total number of elements in the array is 2^p.
        # Let M = 2^p.
        # The initial array contains numbers from 1 to M.
        # The operation allows us to decrement nums[i] by 1 and increment nums[j] by 1,
        # as long as all elements remain non-zero (i.e., >= 1).
        # This operation preserves the sum of the array elements.
        # The goal is to minimize the product of the elements.

        # To minimize the product of positive integers with a fixed sum,
        # we want to make the numbers as "spread out" as possible,
        # meaning some numbers should be as small as possible (1) and others as large as possible.
        #
        # Consider two elements x and y (x < y).
        # If we change them to x-1 and y+1 (possible if x > 1),
        # the product changes from x*y to (x-1)*(y+1) = x*y + x - y - 1.
        # Since x < y, (x - y - 1) is negative.
        # Thus, (x-1)*(y+1) < x*y.
        # This means moving value from a smaller number to a larger number decreases the product.
        # We want to make as many elements as possible equal to 1, and make others large.

        # The optimal strategy for LeetCode 1969 is to transform the array
        # into a state where:
        # - (M / 2 - 1) elements are 1
        # - (M / 2 - 1) elements are (M - 1)
        # - one element is (M / 2)
        # - one element is M
        # where M = 2^p.

        # Let's calculate M.
        max_val = 1 << p  # This is 2^p

        # The elements that become 1 do not affect the product (1 raised to any power is 1).
        # So, the product is:
        # (max_val - 1) ^ (max_val / 2 - 1) * (max_val / 2) * max_val

        # Term 1: (max_val - 1) raised to the power of (max_val / 2 - 1)
        base_term1 = (max_val - 1)
        exponent_term1 = (max_val // 2) - 1

        # Use modular exponentiation for large powers.
        # pow(base, 0, MOD) correctly returns 1, handling the p=1 case where exponent_term1 is 0.
        val_term1 = pow(base_term1, exponent_term1, MOD)

        # Term 2: (max_val / 2)
        val_term2 = (max_val // 2) % MOD

        # Term 3: max_val
        val_term3 = max_val % MOD

        # Calculate the final product modulo MOD
        ans = (val_term1 * val_term2) % MOD
        ans = (ans * val_term3) % MOD

        return ans