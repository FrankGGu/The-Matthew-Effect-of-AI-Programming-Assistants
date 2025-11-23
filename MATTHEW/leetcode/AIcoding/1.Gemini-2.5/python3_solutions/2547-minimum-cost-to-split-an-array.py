import collections

class Solution:
    def minCost(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # dp[i] will store the minimum cost to split the prefix nums[0...i-1]
        # dp[0] is 0, as there's no cost to split an empty array.
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        # Iterate through each possible end point 'i' for the current prefix
        # nums[0...i-1]
        for i in range(1, n + 1):
            # For each dp[i], we consider all possible last segments nums[j...i-1]
            # where 'j' is the starting index of the last segment.
            # dp[i] = min(dp[j] + cost(nums[j...i-1]) + k) for 0 <= j < i

            freq = collections.defaultdict(int)
            current_trimmed_cost = 0 # This stores the cost for the subarray nums[j...i-1]

            # Iterate 'j' from 'i-1' down to '0'.
            # This means we are considering subarrays:
            # nums[i-1:i] (when j = i-1)
            # nums[i-2:i] (when j = i-2)
            # ...
            # nums[0:i] (when j = 0)
            # As 'j' decreases, we are effectively extending the current subarray to the left
            # by including nums[j]. This allows efficient update of current_trimmed_cost.
            for j in range(i - 1, -1, -1):
                val = nums[j]

                # Update frequency of the current element 'val'
                freq[val] += 1

                # If the frequency of 'val' just became 2, it means it now appears
                # at least twice, so it contributes to the trimmed cost.
                # If its frequency was already >= 2 (e.g., 2, 3, etc.), it was already
                # contributing to the trimmed cost, so no change is needed for this element.
                if freq[val] == 2:
                    current_trimmed_cost += 1
                # If freq[val] > 2, it means freq[val] was already >= 2, so it was already counted.
                # If freq[val] == 1, it's not yet a duplicate.

                # Now, current_trimmed_cost holds the cost for the subarray nums[j...i-1]
                # Update dp[i] by considering this split.
                dp[i] = min(dp[i], dp[j] + current_trimmed_cost + k)

        return dp[n]