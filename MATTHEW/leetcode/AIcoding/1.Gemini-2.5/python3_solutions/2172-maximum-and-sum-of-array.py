class Solution:
    def maximumANDSum(self, nums: list[int], numSlots: int) -> int:
        max_state = 1 << (2 * numSlots)
        dp = [-1] * max_state
        dp[0] = 0

        for num_val in nums:
            next_dp = [-1] * max_state

            for slot_state in range(max_state):
                if dp[slot_state] == -1:
                    continue

                current_sum = dp[slot_state]

                for s in range(numSlots):
                    count = (slot_state >> (2 * s)) & 0b11

                    if count < 2:
                        new_slot_state = slot_state - (count << (2 * s)) + ((count + 1) << (2 * s))

                        and_sum_contribution = num_val & (s + 1)

                        next_dp[new_slot_state] = max(next_dp[new_slot_state], current_sum + and_sum_contribution)

            dp = next_dp

        return max(dp)