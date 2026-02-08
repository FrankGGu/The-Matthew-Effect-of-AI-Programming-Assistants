class Solution:
    def purchasePlans(self, nums: List[int], target: int) -> int:
        nums.sort()
        left, right = 0, len(nums) - 1
        res = 0
        while left < right:
            if nums[left] + nums[right] > target:
                right -= 1
            else:
                res += right - left
                left += 1
        return res % 1000000007