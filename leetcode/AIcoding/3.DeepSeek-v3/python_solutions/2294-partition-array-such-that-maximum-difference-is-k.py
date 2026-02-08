class Solution:
    def partitionArray(self, nums: List[int], k: int) -> int:
        nums.sort()
        res = 1
        min_val = nums[0]
        for num in nums:
            if num - min_val > k:
                res += 1
                min_val = num
        return res