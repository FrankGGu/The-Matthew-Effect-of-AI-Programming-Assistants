import math

class Solution:
    def shortestSubarrayWithORAtLeastK(self, nums: list[int], k: int) -> int:
        n = len(nums)
        min_len = math.inf

        l = 0
        # bit_counts[j] stores the count of numbers in the current window [l, r]
        # that have the j-th bit set. Max value of nums[i] is 10^9, which is < 2^30.
        # So we need to track bits from 0 to 29.
        bit_counts = [0] * 30 
        current_or = 0

        for r in range(n):
            # Add nums[r] to the window
            for j in range(30):
                if (nums[r] >> j) & 1:
                    bit_counts[j] += 1
                    # If this bit was previously 0 in current_or and now becomes 1
                    if bit_counts[j] == 1:
                        current_or |= (1 << j)

            # Shrink the window from the left while current_or >= k
            while current_or >= k:
                min_len = min(min_len, r - l + 1)

                # Remove nums[l] from the window
                for j in range(30):
                    if (nums[l] >> j) & 1:
                        bit_counts[j] -= 1
                        # If this bit was previously 1 in current_or and now becomes 0
                        if bit_counts[j] == 0:
                            current_or &= ~(1 << j)
                l += 1

        return min_len if min_len != math.inf else -1