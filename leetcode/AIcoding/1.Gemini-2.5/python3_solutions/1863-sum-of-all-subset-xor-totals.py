from typing import List

class Solution:
    def subsetXORSum(self, nums: List[int]) -> int:
        total_sum = 0
        n = len(nums)

        # Iterate through each bit position
        # The maximum value of nums[i] is 20.
        # The maximum possible XOR sum for a subset will not exceed 31 (binary 11111).
        # Therefore, we only need to check bit positions from 0 to 4 (inclusive).
        # Iterating up to 10 (or any small constant greater than 4) is safe and doesn't affect performance significantly.
        for k in range(10): 

            has_k_bit_set_in_any_num = False
            for num in nums:
                if (num >> k) & 1:
                    has_k_bit_set_in_any_num = True
                    break

            if has_k_bit_set_in_any_num:
                # If at least one number in `nums` has its k-th bit set,
                # then exactly half of the 2^n total subsets will have their XOR total with the k-th bit set.
                # The number of such subsets is 2^(n-1).
                # Each such subset contributes 2^k to the total sum for this specific bit position.
                total_sum += (1 << (n - 1)) * (1 << k)

        return total_sum