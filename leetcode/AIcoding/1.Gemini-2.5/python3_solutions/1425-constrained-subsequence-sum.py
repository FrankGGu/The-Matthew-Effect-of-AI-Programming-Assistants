import collections

class Solution:
    def constrainedSubsetSum(self, nums: list[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n

        # deque stores indices, maintaining dp[index] in decreasing order
        # dq[0] will always be the index of the maximum dp value in the current sliding window
        dq = collections.deque() 

        # Initialize max_overall_sum with the smallest possible value
        max_overall_sum = -float('inf') 

        for i in range(n):
            # Remove elements from the front of the deque if their index is outside the k-window
            # The valid window for a previous element j for dp[i] is [i-k, ..., i-1].
            # So, if dq[0] < i - k, it's too far and should be removed.
            while dq and dq[0] < i - k:
                dq.popleft()

            # Calculate dp[i]
            # dp[i] is nums[i] plus the maximum valid previous dp value (if positive)
            # If deque is empty, there's no valid previous element, so we just take nums[i]
            # max(0, ...) handles the case where extending a previous subsequence would result in a negative sum,
            # in which case it's better to start a new subsequence with nums[i].
            potential_prev_sum = dp[dq[0]] if dq else 0
            dp[i] = nums[i] + max(0, potential_prev_sum)

            # Update the overall maximum sum found so far
            max_overall_sum = max(max_overall_sum, dp[i])

            # Maintain the deque in decreasing order of dp values
            # If dp[i] is greater than or equal to dp[dq[-1]], then dq[-1] is no longer a good candidate
            # for future maximums because i is closer and provides a sum that is at least as good.
            while dq and dp[dq[-1]] <= dp[i]:
                dq.pop()

            # Add the current index to the back of the deque
            dq.append(i)

        return max_overall_sum