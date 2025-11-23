from typing import List

class Solution:
    def findKOr(self, nums: List[int], k: int) -> int:
        k_or_result = 0
        # Iterate through bit positions from 0 to 31 (sufficient for standard 32-bit integers up to 10^9)
        for i in range(32):
            bit_count = 0
            # Count how many numbers in nums have the i-th bit set
            for num in nums:
                if (num >> i) & 1:
                    bit_count += 1

            # If the count of set bits is greater than or equal to k, set the i-th bit in the result
            if bit_count >= k:
                k_or_result |= (1 << i)

        return k_or_result