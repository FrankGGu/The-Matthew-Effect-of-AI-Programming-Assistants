class Solution:
    def checkArray(self, nums: list[int], k: int) -> bool:
        n = len(nums)

        operations_started_at_idx = [0] * n

        active_ops = 0

        for i in range(n):
            if i - k >= 0:
                active_ops -= operations_started_at_idx[i - k]

            current_num_val = nums[i] - active_ops

            if current_num_val < 0:
                return False

            if current_num_val > 0:
                if i > n - k:
                    return False

                operations_started_at_idx[i] = current_num_val
                active_ops += current_num_val

        return True