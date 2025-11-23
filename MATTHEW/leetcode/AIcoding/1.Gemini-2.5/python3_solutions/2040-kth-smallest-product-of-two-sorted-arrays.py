import bisect

class Solution:
    def kthSmallestProduct(self, nums1: list[int], nums2: list[int], k: int) -> int:

        # Binary search range for the answer (the Kth smallest product)
        # Minimum possible product: -10^5 * 10^5 = -10^10
        # Maximum possible product: 10^5 * 10^5 = 10^10
        low = -10**10
        high = 10**10

        # Helper function to count how many products (n1 * n2) are less than or equal to 'val'
        def count_le(val: int) -> int:
            count = 0

            # Pre-split nums2 into negative, zero, and positive parts for efficient counting
            idx_zero_start = bisect.bisect_left(nums2, 0)
            idx_zero_end = bisect.bisect_right(nums2, 0)

            nums2_neg = nums2[:idx_zero_start] # elements < 0
            nums2_zero_count = idx_zero_end - idx_zero_start # count of 0s
            nums2_pos = nums2[idx_zero_end:] # elements > 0

            for n1 in nums1:
                if n1 == 0:
                    # If n1 is 0, product is 0. If val >= 0, all products are <= val.
                    if val >= 0:
                        count += len(nums2)
                elif n1 > 0:
                    # We need n1 * n2 <= val  =>  n2 <= val / n1
                    # 'val / n1' is the upper bound for n2.
                    # bisect_right on the full nums2 array correctly counts all elements
                    # (negative, zero, positive) that satisfy this condition.
                    count += bisect.bisect_right(nums2, val / n1)
                else: # n1 < 0
                    # We need n1 * n2 <= val. Since n1 is negative, dividing by n1 flips the inequality: n2 >= val / n1.
                    # This case needs to be handled carefully based on the sign of n2.

                    # Case 1: n2 < 0 (from nums2_neg)
                    # Product n1 * n2 will be positive.
                    # For n1 * n2 <= val to be true, val must be non-negative.
                    if val >= 0:
                        # We need n2 in nums2_neg such that n2 >= val / n1.
                        # 'val / n1' will be negative or zero.
                        # Count elements in nums2_neg that are greater than or equal to 'val / n1'.
                        count += len(nums2_neg) - bisect.bisect_left(nums2_neg, val / n1)

                    # Case 2: n2 == 0
                    # Product n1 * n2 = 0.
                    # For 0 <= val to be true, val must be non-negative.
                    if val >= 0:
                        count += nums2_zero_count

                    # Case 3: n2 > 0 (from nums2_pos)
                    # Product n1 * n2 will be negative.
                    # If val is non-negative, any negative product is <= val.
                    # If val is negative, we need n1 * n2 <= val  =>  n2 >= val / n1.
                    if val < 0:
                        # We need n2 in nums2_pos such that n2 >= val / n1.
                        # 'val / n1' will be positive.
                        # Count elements in nums2_pos that are greater than or equal to 'val / n1'.
                        count += len(nums2_pos) - bisect.bisect_left(nums2_pos, val / n1)
                    else: # val >= 0, all negative products (n1 * n2 with n2 > 0) are <= val
                        count += len(nums2_pos)

            return count

        ans = high # Initialize answer with a value that is definitely >= Kth smallest

        # Binary search for the Kth smallest product
        while low <= high:
            mid = low + (high - low) // 2

            # If there are 'k' or more products less than or equal to 'mid',
            # then 'mid' could be our answer, or the answer is smaller.
            if count_le(mid) >= k:
                ans = mid
                high = mid - 1 # Try to find a smaller answer
            else:
                # If there are fewer than 'k' products less than or equal to 'mid',
                # then 'mid' is too small, and the answer must be larger.
                low = mid + 1

        return ans