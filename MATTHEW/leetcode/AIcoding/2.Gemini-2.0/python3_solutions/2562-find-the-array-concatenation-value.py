class Solution:
    def findTheArrayConcVal(self, nums: list[int]) -> int:
        l, r = 0, len(nums) - 1
        ans = 0
        while l <= r:
            if l == r:
                ans += nums[l]
            else:
                ans += int(str(nums[l]) + str(nums[r]))
            l += 1
            r -= 1
        return ans