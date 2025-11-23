class Solution:
    def tallestBillboard(self, rods: list[int]) -> int:
        dp = {0: 0}

        for rod in rods:
            new_dp = dp.copy()

            for diff, shorter_sum in dp.items():
                longer_sum = shorter_sum + diff

                # Option 1: Add the current rod to the longer side
                # New state: (longer_sum + rod, shorter_sum)
                # New difference: (longer_sum + rod) - shorter_sum = diff + rod
                # The shorter side sum remains shorter_sum
                new_diff_1 = diff + rod
                new_shorter_sum_1 = shorter_sum
                new_dp[new_diff_1] = max(new_dp.get(new_diff_1, -float('inf')), new_shorter_sum_1)

                # Option 2: Add the current rod to the shorter side
                # New state: (longer_sum, shorter_sum + rod)

                # Case 2a: The shorter side (shorter_sum + rod) is still less than or equal to the longer side (longer_sum)
                if shorter_sum + rod <= longer_sum:
                    new_diff_2a = longer_sum - (shorter_sum + rod)
                    new_shorter_sum_2a = shorter_sum + rod
                    new_dp[new_diff_2a] = max(new_dp.get(new_diff_2a, -float('inf')), new_shorter_sum_2a)
                # Case 2b: The shorter side (shorter_sum + rod) becomes longer than the original longer side (longer_sum)
                else:
                    # The roles of 'longer' and 'shorter' swap.
                    # The new longer side is (shorter_sum + rod)
                    # The new shorter side is (longer_sum)
                    new_diff_2b = (shorter_sum + rod) - longer_sum
                    new_shorter_sum_2b = longer_sum
                    new_dp[new_diff_2b] = max(new_dp.get(new_diff_2b, -float('inf')), new_shorter_sum_2b)

            dp = new_dp

        return dp.get(0, 0)