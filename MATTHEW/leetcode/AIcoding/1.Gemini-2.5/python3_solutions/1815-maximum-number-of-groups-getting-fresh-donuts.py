class Solution:
    def maxHappyGroups(self, batchSize: int, donuts: list[int]) -> int:

        # counts[r] stores the number of donuts with remainder r when divided by batchSize
        counts = [0] * batchSize

        # Initialize the number of happy groups.
        # Donuts with remainder 0 can always form a happy group by themselves.
        ans = 0

        for donut in donuts:
            remainder = donut % batchSize
            if remainder == 0:
                ans += 1
            else:
                counts[remainder] += 1

        # Greedy pairing for (r, batchSize - r)
        # If we have a donut with remainder `r` and another with remainder `batchSize - r`,
        # they can form a happy group together. We maximize such pairings.
        # This loop goes up to batchSize // 2.
        # For example, if batchSize is 9, r goes from 1 to 4. Pairs (1,8), (2,7), (3,6), (4,5).
        # If batchSize is 8, r goes from 1 to 4. Pairs (1,7), (2,6), (3,5).
        # The case r = batchSize - r (e.g., r=4 for batchSize=8) is handled separately.
        for r in range(1, (batchSize // 2) + 1):
            if r == batchSize - r: # Special case for even batchSize, e.g., r = batchSize/2
                # Donuts with remainder batchSize/2 can form pairs among themselves.
                ans += counts[r] // 2
                counts[r] %= 2 # At most one such donut can remain
            else:
                # Pair up donuts with remainder r and batchSize - r
                pairs = min(counts[r], counts[batchSize - r])
                ans += pairs
                counts[r] -= pairs
                counts[batchSize - r] -= pairs

        # Dynamic Programming for the remaining donuts.
        # The state for DP is (current_counts_tuple, current_remainder_in_group).
        # current_counts_tuple: A tuple representing the remaining counts of donuts for remainders 1 to batchSize-1.
        # current_remainder_in_group: The sum of remainders of donuts currently in the group being formed (modulo batchSize).

        # Convert counts list (excluding counts[0]) to a tuple for memoization key.
        # counts[1:] means we are only considering remainders 1 to batchSize-1.
        initial_counts_tuple = tuple(counts[1:])

        memo = {}

        def solve(current_counts_tuple, current_remainder_in_group):
            # If this state has been computed before, return the memoized result.
            if (current_counts_tuple, current_remainder_in_group) in memo:
                return memo[(current_counts_tuple, current_remainder_in_group)]

            max_additional_groups = 0

            # Iterate through all possible remainders (1 to batchSize-1) to pick the next donut.
            for r_val in range(1, batchSize):
                # Check if there are donuts with this remainder available.
                # current_counts_tuple is indexed from 0 to batchSize-2,
                # where index 0 corresponds to remainder 1, index 1 to remainder 2, etc.
                if current_counts_tuple[r_val - 1] > 0:

                    # Create a new counts tuple for the next state by decrementing the count of r_val.
                    new_counts = list(current_counts_tuple)
                    new_counts[r_val - 1] -= 1

                    # Calculate the new remainder sum for the current group.
                    next_remainder_in_group = (current_remainder_in_group + r_val) % batchSize

                    if next_remainder_in_group == 0:
                        # If the group is completed (remainder sum is 0),
                        # we get 1 happy group and then start forming a new group (current_remainder_in_group resets to 0).
                        max_additional_groups = max(max_additional_groups, 1 + solve(tuple(new_counts), 0))
                    else:
                        # If the group is not yet completed, continue building it.
                        max_additional_groups = max(max_additional_groups, solve(tuple(new_counts), next_remainder_in_group))

            # Memoize the result for the current state.
            memo[(current_counts_tuple, current_remainder_in_group)] = max_additional_groups
            return max_additional_groups

        # Start the DP with the remaining donuts and an empty group (current_remainder_in_group = 0).
        # Add the result from DP to the greedily calculated groups.
        ans += solve(initial_counts_tuple, 0)

        return ans