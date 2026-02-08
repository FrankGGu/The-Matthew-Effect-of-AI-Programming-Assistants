import math

class Solution:
    def canPartition(self, nums: list[int]) -> bool:
        n = len(nums)
        if n < 2:
            return False

        zero_count = 0
        for x in nums:
            if x == 0:
                zero_count += 1

        if zero_count >= 2:
            return True
        if zero_count == 1:
            return False

        total_log_abs_sum = 0.0
        total_sign_prod = 1
        for x in nums:
            total_log_abs_sum += math.log(abs(x))
            if x < 0:
                total_sign_prod *= -1

        if total_sign_prod == -1:
            return False

        epsilon = 1e-9

        current_log_abs_sum = 0.0

        for i in range(n - 1):
            current_log_abs_sum += math.log(abs(nums[i]))

            if abs(2 * current_log_abs_sum - total_log_abs_sum) < epsilon:
                return True

        return False