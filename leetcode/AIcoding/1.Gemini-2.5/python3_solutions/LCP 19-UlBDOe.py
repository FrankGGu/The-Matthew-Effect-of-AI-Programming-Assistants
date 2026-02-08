class Solution:
    def minimumOperations(self, leaves: str) -> int:
        n = len(leaves)

        # dp0: minimum operations for leaves[0...i] to be in the first 'r' section (all 'r's)
        # dp1: minimum operations for leaves[0...i] to be in the middle 'y' section (r...y...)
        # dp2: minimum operations for leaves[0...i] to be in the third 'r' section (r...y...r...)

        # Initialize for the first leaf (index 0)
        # For leaves[0], it must be 'r' for dp0.
        # dp1 and dp2 are not possible with only one leaf.
        dp0 = 1 if leaves[0] == 'y' else 0
        dp1 = float('inf')
        dp2 = float('inf')

        # Iterate from the second leaf (index 1) to the end
        for i in range(1, n):
            is_y = (leaves[i] == 'y')
            is_r = (leaves[i] == 'r')

            # Calculate costs to change current leaf
            cost_to_be_r = 1 if is_y else 0
            cost_to_be_y = 1 if is_r else 0

            # Store the DP values for the current iteration (i) before they are updated
            # This is crucial because dp1 calculation depends on dp0 from previous step,
            # and dp2 calculation depends on dp1 from previous step.
            next_dp0 = float('inf')
            next_dp1 = float('inf')
            next_dp2 = float('inf')

            # Calculate next_dp0: leaves[0...i] are all 'r's
            # This state can only come from leaves[0...i-1] being all 'r's (dp0),
            # and leaves[i] is changed to 'r' if it's 'y'.
            next_dp0 = dp0 + cost_to_be_r

            # Calculate next_dp1: leaves[0...i] are 'r...y...'
            # This state means leaves[i] is 'y'. It can come from two scenarios:
            # 1. leaves[0...i-1] were all 'r's (dp0), and leaves[i] becomes the first 'y'.
            # 2. leaves[0...i-1] were already 'r...y...' (dp1), and leaves[i] extends the 'y' section.
            next_dp1 = min(dp0, dp1) + cost_to_be_y

            # Calculate next_dp2: leaves[0...i] are 'r...y...r...'
            # This state means leaves[i] is 'r'. It can come from two scenarios:
            # 1. leaves[0...i-1] were 'r...y...' (dp1), and leaves[i] becomes the first 'r' of the third section.
            # 2. leaves[0...i-1] were already 'r...y...r...' (dp2), and leaves[i] extends the 'r' section.
            next_dp2 = min(dp1, dp2) + cost_to_be_r

            # Update dp values for the next iteration
            dp0, dp1, dp2 = next_dp0, next_dp1, next_dp2

        # The final answer is the minimum operations to achieve the 'r...y...r...' pattern
        # for the entire string, which is dp2 at the last index.
        return dp2