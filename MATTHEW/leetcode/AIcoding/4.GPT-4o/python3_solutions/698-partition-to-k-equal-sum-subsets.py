class Solution:
    def canPartitionKSubsets(self, nums: List[int], k: int) -> bool:
        total_sum = sum(nums)
        if total_sum % k != 0:
            return False
        target = total_sum // k
        nums.sort(reverse=True)

        def backtrack(index, k, current_sum):
            if k == 0:
                return True
            if current_sum == target:
                return backtrack(0, k - 1, 0)
            for i in range(index, len(nums)):
                if nums[i] + current_sum <= target:
                    nums[i], nums[index] = nums[index], nums[i]
                    if backtrack(index + 1, k, current_sum + nums[index]):
                        return True
                    nums[i], nums[index] = nums[index], nums[i]
            return False

        return backtrack(0, k, 0)