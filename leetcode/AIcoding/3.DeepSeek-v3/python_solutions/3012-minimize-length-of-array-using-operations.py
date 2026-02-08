class Solution:
    def minimumArrayLength(self, nums: List[int]) -> int:
        min_num = min(nums)
        for num in nums:
            if num % min_num != 0:
                return 1
        return (nums.count(min_num) + 1) // 2