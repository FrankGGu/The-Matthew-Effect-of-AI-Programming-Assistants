class Solution:
    def minCapability(self, nums: list[int], k: int) -> int:
        def check(x: int) -> bool:
            """
            Checks if it's possible to rob at least k houses such that
            the maximum amount robbed from any house is at most x.
            """
            rob_count = 0  # Max houses robbed if the current house is robbed
            skip_count = 0 # Max houses robbed if the current house is skipped

            for num in nums:
                if num <= x:
                    # If we can rob the current house (value <= x)
                    # new_rob_count: current house is robbed, so previous must have been skipped
                    # new_skip_count: current house is skipped, take max from previous states
                    new_rob_count = skip_count + 1
                    new_skip_count = max(rob_count, skip_count)
                else:
                    # If we cannot rob the current house (value > x)
                    # new_rob_count: cannot rob current, so 0
                    # new_skip_count: current house is skipped, take max from previous states
                    new_rob_count = 0
                    new_skip_count = max(rob_count, skip_count)

                rob_count = new_rob_count
                skip_count = new_skip_count

            return max(rob_count, skip_count) >= k

        # Binary search for the minimum possible maximum capability
        # The range for the answer is [0, max(nums)]
        low = 0
        high = max(nums)
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid      # mid is a possible answer, try for a smaller one
                high = mid - 1
            else:
                low = mid + 1  # mid is too small, need a larger capability

        return ans