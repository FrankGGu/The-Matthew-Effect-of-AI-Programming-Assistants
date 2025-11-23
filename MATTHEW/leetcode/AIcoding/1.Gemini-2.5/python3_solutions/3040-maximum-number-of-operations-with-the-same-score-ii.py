import functools

class Solution:
    def maxOperations(self, nums: list[int]) -> int:
        n = len(nums)

        def calculate_max_ops(target_sum: int) -> int:
            @functools.lru_cache(None)
            def dp(left: int, right: int) -> int:
                if left >= right:
                    return 0

                max_current_ops = 0

                if left + 1 <= right and nums[left] + nums[left+1] == target_sum:
                    max_current_ops = max(max_current_ops, 1 + dp(left + 2, right))

                if nums[left] + nums[right] == target_sum:
                    max_current_ops = max(max_current_ops, 1 + dp(left + 1, right - 1))

                if right - 1 >= left and nums[right-1] + nums[right] == target_sum:
                    max_current_ops = max(max_current_ops, 1 + dp(left, right - 2))

                return max_current_ops

            return dp(0, n - 1)

        ans = 0

        if n < 2:
            return 0

        target1 = nums[0] + nums[1]
        ans = max(ans, calculate_max_ops(target1))

        target2 = nums[0] + nums[n-1]
        ans = max(ans, calculate_max_ops(target2))

        target3 = nums[n-2] + nums[n-1]
        ans = max(ans, calculate_max_ops(target3))

        return ans