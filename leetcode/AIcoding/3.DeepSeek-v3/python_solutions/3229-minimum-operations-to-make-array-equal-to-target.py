class Solution:
    def minOperations(self, nums: List[int], target: int) -> int:
        total = sum(nums)
        if total < target:
            return -1
        nums.sort(reverse=True)
        operations = 0
        i = 0
        while target > 0:
            if i < len(nums) and nums[i] <= target:
                target -= nums[i]
                total -= nums[i]
                i += 1
            else:
                if i < len(nums):
                    total -= nums[i]
                operations += 1
                nums[i] //= 2
        return operations