class Solution:
    def maxSumTwoNoOverlap(self, nums: List[int], firstLen: int, secondLen: int) -> int:
        n = len(nums)

        # Calculate prefix sums
        # prefix_sum[i] stores the sum of nums[0...i-1]
        # prefix_sum[0] = 0
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        # Helper function to find the maximum sum when the first subarray has length L1
        # and comes before the second subarray of length L2.
        def solve(L1, L2):
            max_total_sum = 0

            # max_L1_sum_so_far stores the maximum sum of an L1-length subarray
            # that ends at or before the index (current_L2_start_idx - 1).
            # This ensures non-overlapping.
            max_L1_sum_so_far = 0 

            # Iterate through all possible ending positions for the L2 subarray.
            # 'i' represents the exclusive end index of the L2 subarray.
            # So, the L2 subarray is nums[i - L2 : i - 1].
            # The L1 subarray must end at or before index (i - L2 - 1).
            # The smallest possible 'i' is L1 + L2, which corresponds to
            # L1 subarray: nums[0 : L1-1]
            # L2 subarray: nums[L1 : L1+L2-1]
            for i in range(L1 + L2, n + 1):
                # Calculate sum of the L1 subarray ending at index (i - L2 - 1).
                # This subarray is nums[i - L2 - L1 : i - L2 - 1].
                # Its sum is prefix_sum[ (i - L2 - 1) + 1 ] - prefix_sum[i - L2 - L1]
                # which simplifies to prefix_sum[i - L2] - prefix_sum[i - L2 - L1].
                current_L1_sum_candidate = prefix_sum[i - L2] - prefix_sum[i - L2 - L1]

                # Update max_L1_sum_so_far with the maximum L1 sum found up to this point
                # (ending before the current L2 subarray starts).
                max_L1_sum_so_far = max(max_L1_sum_so_far, current_L1_sum_candidate)

                # Calculate sum of the current L2 subarray ending at index (i - 1).
                # This subarray is nums[i - L2 : i - 1].
                current_L2_sum = prefix_sum[i] - prefix_sum[i - L2]

                # Update the overall maximum total sum.
                max_total_sum = max(max_total_sum, max_L1_sum_so_far + current_L2_sum)

            return max_total_sum

        # Case 1: firstLen subarray comes before secondLen subarray
        res1 = solve(firstLen, secondLen)

        # Case 2: secondLen subarray comes before firstLen subarray
        res2 = solve(secondLen, firstLen)

        # The overall maximum is the greater of the two cases
        return max(res1, res2)