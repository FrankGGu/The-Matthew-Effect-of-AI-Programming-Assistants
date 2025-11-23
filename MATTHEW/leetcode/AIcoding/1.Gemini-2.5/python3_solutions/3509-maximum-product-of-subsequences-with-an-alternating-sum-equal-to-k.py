class Solution:
    def maximumProduct(self, nums: list[int], k: int) -> int:
        OFFSET = 2500
        MAX_SUM_RANGE = 5001  # Sums can range from -2500 to 2500, inclusive

        # dp[s_offset] stores a list [max_prod_ending_with_plus, max_prod_ending_with_minus]
        # max_prod_ending_with_plus: maximum product of a subsequence with sum (s_offset - OFFSET)
        #                            where the last element was added to the sum.
        # max_prod_ending_with_minus: maximum product of a subsequence with sum (s_offset - OFFSET)
        #                             where the last element was subtracted from the sum.
        # Initialize with 0, meaning no such subsequence has been found yet for that sum/sign.
        dp = [[0, 0] for _ in range(MAX_SUM_RANGE)]

        # Keep track of sum offsets that have non-zero products to optimize iteration.
        active_sums = set()

        for num in nums:
            # Create a new DP table for the current `num` to avoid using states
            # that are being updated in the current iteration.
            next_dp = [list(pair) for pair in dp]
            next_active_sums = set(active_sums)

            # Option 1: Extend existing subsequences
            # Iterate over the sum offsets that had active subsequences before processing `num`.
            for s_offset in active_sums:
                prev_sum = s_offset - OFFSET
                prev_prod_plus, prev_prod_minus = dp[s_offset]

                # If a subsequence ending with +X (prev_prod_plus > 0) exists for prev_sum,
                # we can append `num` to it, making it -num in the alternating sum.
                if prev_prod_plus > 0:
                    new_sum = prev_sum - num
                    new_s_offset = new_sum + OFFSET
                    if 0 <= new_s_offset < MAX_SUM_RANGE:
                        new_prod = prev_prod_plus * num
                        # Update the max product for subsequences ending with -num
                        next_dp[new_s_offset][1] = max(next_dp[new_s_offset][1], new_prod)
                        next_active_sums.add(new_s_offset)

                # If a subsequence ending with -X (prev_prod_minus > 0) exists for prev_sum,
                # we can append `num` to it, making it +num in the alternating sum.
                if prev_prod_minus > 0:
                    new_sum = prev_sum + num
                    new_s_offset = new_sum + OFFSET
                    if 0 <= new_s_offset < MAX_SUM_RANGE:
                        new_prod = prev_prod_minus * num
                        # Update the max product for subsequences ending with +num
                        next_dp[new_s_offset][0] = max(next_dp[new_s_offset][0], new_prod)
                        next_active_sums.add(new_s_offset)

            # Option 2: Start a new subsequence with `num` itself.
            # This subsequence will have sum `num` and product `num`, with `num` being added.
            current_sum_offset = num + OFFSET
            next_dp[current_sum_offset][0] = max(next_dp[current_sum_offset][0], num)
            next_active_sums.add(current_sum_offset)

            # Update the DP table and active sums for the next iteration.
            dp = next_dp
            active_sums = next_active_sums

        # After processing all numbers, find the maximum product for the target sum `k`.
        target_k_offset = k + OFFSET
        ans = 0  # Initialize with 0. If no subsequence is found, it will remain 0.

        if 0 <= target_k_offset < MAX_SUM_RANGE:
            # The target sum `k` could be achieved by a subsequence ending with +k or -k.
            # We take the maximum of these two possibilities.
            ans = max(dp[target_k_offset][0], dp[target_k_offset][1])

        # If `ans` is 0, it means no valid subsequence was found for sum `k`.
        # According to the problem, return -1 in this case. Otherwise, return the product.
        return ans if ans > 0 else -1