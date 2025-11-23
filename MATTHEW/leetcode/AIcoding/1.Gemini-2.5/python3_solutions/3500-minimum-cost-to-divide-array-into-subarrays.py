import collections

class Solution:
    def minCost(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # trim_values[j][i] will store trim(nums[j...i-1])
        # This means trim_values[j][i] is the trim cost for the subarray starting at index j
        # and ending at index i-1 (inclusive).
        # The length of this subarray is i - j.
        trim_values = [[0] * (n + 1) for _ in range(n)]

        # Precompute trim costs for all possible subarrays
        for j in range(n):
            freq = collections.defaultdict(int)
            current_trim = 0
            for i in range(j, n):
                # Add nums[i] to the current subarray nums[j...i]
                x = nums[i]
                freq[x] += 1

                if freq[x] == 2:
                    # If this is the second occurrence, both instances now contribute to trim
                    current_trim += 2
                elif freq[x] > 2:
                    # If this is the third or more occurrence, this single instance contributes 1 more to trim
                    current_trim += 1

                # Store the current trim value for the subarray nums[j...i]
                # This corresponds to trim_values[j][i+1] in our 0-indexed start, exclusive-end scheme.
                trim_values[j][i+1] = current_trim

        # dp[i] will store the minimum cost to divide the prefix nums[0...i-1]
        # into subarrays.
        dp = [float('inf')] * (n + 1)
        dp[0] = 0  # Base case: cost to divide an empty prefix is 0

        # Fill the dp table
        for i in range(1, n + 1): # i represents the current length of the prefix (or end index + 1)
            for j in range(i): # j represents the split point, meaning nums[j...i-1] is the last subarray
                # dp[j] is the minimum cost for the prefix nums[0...j-1]
                # The last subarray is nums[j...i-1]
                # Its cost is trim_values[j][i] (precomputed trim cost) + k
                sub_array_cost = trim_values[j][i] + k
                dp[i] = min(dp[i], dp[j] + sub_array_cost)

        return dp[n]