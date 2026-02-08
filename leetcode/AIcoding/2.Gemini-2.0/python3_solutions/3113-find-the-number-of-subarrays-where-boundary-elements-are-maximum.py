class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        ans = 0
        l = -1
        valid_l = -1
        for r in range(n):
            if nums[r] == k:
                valid_l = l
                l = r
            if nums[r] > k:
                l = r
                valid_l = r
            ans += max(0, valid_l + 1)
        return ans