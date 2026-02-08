import math

class Solution:
    def minSpaceWastedKResizing(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # dp[i][j] represents the minimum total space wasted for the first i files (nums[0] to nums[i-1])
        # using exactly j resizing operations.
        # The number of blocks would be j+1.
        # dp table size: (n+1) x (k+1)
        dp = [[math.inf] * (k + 1) for _ in range(n + 1)]

        # Base case: 0 files, 0 operations, 0 waste
        dp[0][0] = 0

        # Iterate through the number of files considered (from 1 to n)
        for i in range(1, n + 1):
            # Iterate through the number of resizing operations (from 0 to k)
            for j in range(k + 1):
                current_max_in_segment = 0
                current_sum_in_segment = 0

                # Iterate backwards from i-1 down to 0 to find the starting point of the current segment.
                # This segment is nums[prev_i ... i-1]
                for prev_i in range(i - 1, -1, -1):
                    current_max_in_segment = max(current_max_in_segment, nums[prev_i])
                    current_sum_in_segment += nums[prev_i]

                    segment_length = i - prev_i
                    current_waste_in_segment = current_max_in_segment * segment_length - current_sum_in_segment

                    # If j is 0, it means no resizing operations are allowed for the first 'i' files.
                    # This implies all 'i' files must be in a single block.
                    # So, prev_i must be 0 to form a single segment from nums[0] to nums[i-1].
                    if j == 0:
                        if prev_i == 0:
                            dp[i][j] = min(dp[i][j], current_waste_in_segment)
                    # If j > 0, we can use j-1 operations for the first 'prev_i' files
                    # and the j-th operation creates the segment from 'prev_i' to 'i-1'.
                    else:
                        if dp[prev_i][j - 1] != math.inf:
                            dp[i][j] = min(dp[i][j], dp[prev_i][j - 1] + current_waste_in_segment)

        # The problem asks for "at most K resizing operations".
        # So we need to find the minimum waste among all possible operations from 0 to k.
        min_total_waste = math.inf
        for j in range(k + 1):
            min_total_waste = min(min_total_waste, dp[n][j])

        return min_total_waste