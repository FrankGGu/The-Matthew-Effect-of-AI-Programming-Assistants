class Solution:
    def maxSumAfterPartitioning(self, arr: list[int], k: int) -> int:
        n = len(arr)

        # dp[i] will store the maximum sum for the subarray arr[0...i-1]
        dp = [0] * (n + 1)

        # Iterate through each possible end point of the array
        for i in range(1, n + 1):
            current_max = 0
            # Iterate backwards from i-1 to find the start point 'j' of the last partition
            # The last partition arr[j...i-1] must have length at most k
            # So, (i-1) - j + 1 <= k  =>  i - j <= k  =>  j >= i - k
            # Also, j must be at least 0
            for j in range(i - 1, max(-1, i - k - 1), -1):
                # current_max keeps track of the maximum element in the current partition arr[j...i-1]
                current_max = max(current_max, arr[j])

                # Calculate the length of the current partition
                length_of_partition = i - j

                # Update dp[i] using the maximum sum from the previous state dp[j]
                # plus the sum contributed by the current partition (max_element * length)
                dp[i] = max(dp[i], dp[j] + current_max * length_of_partition)

        return dp[n]