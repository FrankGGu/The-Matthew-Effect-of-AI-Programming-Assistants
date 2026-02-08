class Solution:
    def maximumBeauty(self, nums: List[int], k: int) -> int:
        nums.sort()
        l, r = 0, 0
        ans = 0
        while r < len(nums):
            while nums[r] - nums[l] > 2 * k:
                l += 1
            ans = max(ans, r - l + 1)
            r += 1
        return ans