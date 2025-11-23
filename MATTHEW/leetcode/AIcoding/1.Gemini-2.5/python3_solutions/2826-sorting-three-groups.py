class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        max_val = 500  # Constraints: 1 <= nums[i] <= 500

        # dp1[val]: minimum changes for the current prefix (nums[0...i])
        # such that all elements are changed to 'val' (forming group 1).
        # dp2[val]: minimum changes for the current prefix (nums[0...i])
        # such that it's partitioned into two groups [v1...v1, val...val] where v1 <= val.
        # dp3[val]: minimum changes for the current prefix (nums[0...i])
        # such that it's partitioned into three groups [v1...v1, v2...v2, val...val] where v1 <= v2 <= val.

        # Initialize dp arrays for an empty prefix (0 changes)
        # We use float('inf') for states that are not reachable or not yet computed.
        # For the first element, all dp values will be computed based on its cost.
        dp1 = [0] * (max_val + 1)
        dp2 = [0] * (max_val + 1)
        dp3 = [0] * (max_val + 1)

        for i in range(n):
            current_num = nums[i]

            # Create temporary arrays to store results for the current prefix (nums[0...i])
            # This prevents using values from the current iteration when they should be from the previous.
            next_dp1 = [float('inf')] * (max_val + 1)
            next_dp2 = [float('inf')] * (max_val + 1)
            next_dp3 = [float('inf')] * (max_val + 1)

            # These variables will store the minimum dp values for previous groups
            # up to the current 'val', used for transitions between groups.
            min_prev_dp1 = float('inf')
            min_prev_dp2 = float('inf')

            for val in range(1, max_val + 1):
                # Cost to change nums[i] to 'val'
                cost = 1 if current_num != val else 0

                # Update min_prev_dp1 and min_prev_dp2 for prefix minimums
                # These represent the minimum cost to form a sequence ending with a value <= 'val'
                # in the respective group.
                min_prev_dp1 = min(min_prev_dp1, dp1[val])
                min_prev_dp2 = min(min_prev_dp2, dp2[val])

                # Calculate next_dp1[val]: nums[0...i] are all changed to 'val'.
                # This means nums[0...i-1] must have also been changed to 'val'.
                next_dp1[val] = dp1[val] + cost

                # Calculate next_dp2[val]: nums[0...i] end with 'val' in group 2.
                # Two possibilities for nums[0...i-1]:
                # 1. It ended with 'val' in group 2 (continue group 2). Cost: dp2[val] + cost.
                # 2. It ended with some v1 <= 'val' in group 1 (transition from group 1 to group 2).
                #    Cost: min_prev_dp1 + cost.
                next_dp2[val] = min(dp2[val] + cost, min_prev_dp1 + cost)

                # Calculate next_dp3[val]: nums[0...i] end with 'val' in group 3.
                # Two possibilities for nums[0...i-1]:
                # 1. It ended with 'val' in group 3 (continue group 3). Cost: dp3[val] + cost.
                # 2. It ended with some v2 <= 'val' in group 2 (transition from group 2 to group 3).
                #    Cost: min_prev_dp2 + cost.
                next_dp3[val] = min(dp3[val] + cost, min_prev_dp2 + cost)

            # Update the dp arrays for the next iteration
            dp1 = next_dp1
            dp2 = next_dp2
            dp3 = next_dp3

        # The final answer is the minimum cost across all possible ending values and all three groups.
        return min(min(dp1), min(dp2), min(dp3))