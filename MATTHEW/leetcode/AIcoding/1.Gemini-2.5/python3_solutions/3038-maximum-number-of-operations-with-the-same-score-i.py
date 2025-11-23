class Solution:
    def maxOperations(self, nums: list[int]) -> int:
        if len(nums) < 2:
            return 0

        target_score = nums[0] + nums[1]
        operations_count = 1

        for i in range(2, len(nums), 2):
            if i + 1 < len(nums):
                current_sum = nums[i] + nums[i+1]
                if current_sum == target_score:
                    operations_count += 1
                else:
                    break
            else:
                break

        return operations_count