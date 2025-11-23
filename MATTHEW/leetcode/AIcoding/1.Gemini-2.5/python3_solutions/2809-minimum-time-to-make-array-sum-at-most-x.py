class Solution:
    def minimumTime(self, nums: list[int], bumps: list[int], x: int) -> int:
        n = len(nums)

        def check(t_val: int) -> bool:
            """
            Checks if it's possible to make the array sum at most x at a given time t_val.
            For each element nums[i], we have two choices:
            1. Set nums[i] to 0, contributing 0 to the total sum.
            2. Keep nums[i], in which case its value becomes nums[i] + t_val * bumps[i].
            To minimize the total sum, for each element, we choose the minimum of these two options.
            """
            current_sum = 0
            for i in range(n):
                # Each element contributes min(0, nums[i] + t_val * bumps[i]) to the sum.
                # If nums[i] + t_val * bumps[i] is positive, setting it to 0 is better.
                # If nums[i] + t_val * bumps[i] is zero or negative, keeping it is better or equal.
                current_sum += min(0, nums[i] + t_val * bumps[i])
            return current_sum <= x

        # Binary search for the minimum time 't'.
        # The lower bound for 't' is 0.
        # The upper bound for 't' can be estimated.
        # If nums[i] is large (e.g., 10^9), bumps[i] is negative (e.g., -1), and x is very small (e.g., -10^15),
        # we might need t to be large.
        # Example: nums[i] + t * bumps[i] <= x
        # 10^9 + t * (-1) <= -10^15
        # 10^9 - t <= -10^15
        # t >= 10^9 + 10^15
        # So, t can be around 10^15. A safe upper bound is 2 * 10^15 + 7.
        low = 0
        high = 2 * 10**15 + 7  # A sufficiently large upper bound for t
        ans = high  # Initialize with a value indicating impossibility or maximum possible t

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1  # Try for a smaller t
            else:
                low = mid + 1   # Need a larger t

        return ans